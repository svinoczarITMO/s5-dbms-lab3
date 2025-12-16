#!/usr/bin/bash

echo "4 ЭТАП: Логическое повреждение данных и восстановление\n"

PRIMARY_PORT=9414
STANDBY_PORT=9415
DB_NAME="wetredsoup"
DB_USER="aleksandrbabushkin"
DB_PASS="${PGPASSWORD:-44}"
export PGPASSWORD="$DB_PASS"

# --------------------------------------------------------------------------------------------
echo "\nПересоздание резервного узла (pg_basebackup)\n"

pg_ctl -D "$PGDATA_STANDBY" stop -m fast 2>/dev/null || true

rm -rf "$PGDATA_STANDBY"
mkdir -p "$PGDATA_STANDBY"
chmod 0700 "$PGDATA_STANDBY"

echo "Определяем путь tablespace cln78 на primary"
SOURCE_TS_CLN78="$(
  psql -p $PRIMARY_PORT -d postgres -Atc \
    "SELECT pg_tablespace_location(oid) FROM pg_tablespace WHERE spcname='cln78';"
)"

TS_CLN78_STANDBY="$DBMS_ROOT/cln78_reserve"
rm -rf "$TS_CLN78_STANDBY"
mkdir -p "$TS_CLN78_STANDBY"

echo "pg_basebackup с tablespace-mapping:"
echo "  source TS: $SOURCE_TS_CLN78"
echo "  target TS: $TS_CLN78_STANDBY"

pg_basebackup \
  -h localhost -p $PRIMARY_PORT -U "$DB_USER"\
  -D "$PGDATA_STANDBY" \
  -X stream \
  --tablespace-mapping="$SOURCE_TS_CLN78=$TS_CLN78_STANDBY"

# --------------------------------------------------------------------------------------------
echo "\nПодготовка конфигурации резервного узла\n"

cp "$DBMS_ROOT/configuration/postgresql.conf" "$PGDATA_STANDBY/postgresql.conf"
cp "$DBMS_ROOT/configuration/pg_hba.conf" "$PGDATA_STANDBY/pg_hba.conf"

CONF="$PGDATA_STANDBY/postgresql.conf"
TMP="${CONF}.tmp"

grep -vE '^[[:space:]]*(port|hot_standby|archive_mode|restore_command)[[:space:]]*=' \
  "$CONF" > "$TMP"
mv "$TMP" "$CONF"
printf "\n" >> "$CONF"

echo "
port = $STANDBY_PORT
hot_standby = on
archive_mode = off
primary_conninfo = 'host=localhost port=$PRIMARY_PORT user=$DB_USER password=$DB_PASS'
" >> "$CONF"

touch "$PGDATA_STANDBY/standby.signal"

chmod 0700 "$PGDATA_STANDBY"

# --------------------------------------------------------------------------------------------
echo "\nЗапуск standby\n"

pg_ctl -D "$PGDATA_STANDBY" start

psql -p $STANDBY_PORT -d postgres -c "SELECT pg_is_in_recovery();"

# --------------------------------------------------------------------------------------------
echo "\nДобавление новых данных на основном узле\n"

psql -p $PRIMARY_PORT -d "$DB_NAME" -f "$DBMS_ROOT/test_data.sql"

psql -p $PRIMARY_PORT -d "$DB_NAME" -c "SELECT * FROM test ORDER BY id;"
psql -p $PRIMARY_PORT -d "$DB_NAME" -c "SELECT * FROM test2 ORDER BY id;"

# --------------------------------------------------------------------------------------------
echo "\nФиксация времени и форсирование WAL\n"

BACKUP_TIME="$(date +%Y%m%d_%H%M%S)"
echo "Время перед ошибкой: $BACKUP_TIME"

# чекпоинт
psql -p $PRIMARY_PORT -d postgres -c "CHECKPOINT;"
# переключаем wal сегмент
psql -p $PRIMARY_PORT -d postgres -c "SELECT pg_switch_wal();"

# --------------------------------------------------------------------------------------------
echo "\nОжидание, пока standby догонит primary\n"

for i in {1..15}; do
  P1=$(psql -h localhost -p $PRIMARY_PORT -d "$DB_NAME" -Atc "SELECT count(*) FROM test;")
  S1=$(psql -h localhost -p $STANDBY_PORT -d "$DB_NAME" -Atc "SELECT count(*) FROM test;" || echo "0")

  P2=$(psql -h localhost -p $PRIMARY_PORT -d "$DB_NAME" -Atc "SELECT count(*) FROM test2;")
  S2=$(psql -h localhost -p $STANDBY_PORT -d "$DB_NAME" -Atc "SELECT count(*) FROM test2;" || echo "0")

  echo "test primary=$P1 standby=$S1 | test2 primary=$P2 standby=$S2"
  

  if [ "$P1" = "$S1" ] && [ "$P2" = "$S2" ]; then
    break
  fi
  # sleep 1
done

psql -p $STANDBY_PORT -d "$DB_NAME" -c "SELECT * FROM test ORDER BY id;"
psql -p $STANDBY_PORT -d "$DB_NAME" -c "SELECT * FROM test2 ORDER BY id;"

# --------------------------------------------------------------------------------------------
echo "\nЛогический дамп с резервного узла (pg_dump)\n"

BACKUP_FILE="$BACKUP_DIR/logical_backup_${BACKUP_TIME}.dump"
pg_dump -p $STANDBY_PORT -d "$DB_NAME" -F c -f "$BACKUP_FILE"

ls -lh "$BACKUP_FILE"

# --------------------------------------------------------------------------------------------
echo "\nЛогическое повреждение: DELETE на основном узле\n"

ERROR_TIME_SQL=$(date '+%Y-%m-%d %H:%M:%S%z')
echo "$ERROR_TIME_SQL" > "$DBMS_ROOT/error_time_pitr.txt"
echo "ВРЕМЯ ПЕРЕД DELETE %2: $ERROR_TIME_SQL"

psql -p $PRIMARY_PORT -d "$DB_NAME" -c "DELETE FROM test WHERE id % 2 = 0;"
psql -p $PRIMARY_PORT -d "$DB_NAME" -c "SELECT * FROM test ORDER BY id;"

# --------------------------------------------------------------------------------------------
echo "\nВосстановление основного узла из дампа\n"

pg_restore -p $PRIMARY_PORT -d "$DB_NAME" --clean --if-exists "$BACKUP_FILE"

# --------------------------------------------------------------------------------------------
echo "\nПроверка восстановления\n"

psql -p $PRIMARY_PORT -d "$DB_NAME" -c "SELECT * FROM test ORDER BY id;"
psql -p $PRIMARY_PORT -d "$DB_NAME" -c "SELECT * FROM test2 ORDER BY id;"

echo "\n4 ЭТАП ЗАВЕРШЕН"