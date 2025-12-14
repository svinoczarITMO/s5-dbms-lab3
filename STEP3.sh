#!/usr/bin/bash

export PSQL_PAGER=cat
export PAGER=cat

echo "3 ЭТАП: Повреждение файлов БД (удаление WAL) и восстановление основного узла\n"

# --------------------------------------------------------------------------------------------

echo "\nПодготовка\n"
pg_ctl -D "$PGDATA_PRIMARY" start

# --------------------------------------------------------------------------------------------

echo "\nФиксация OID табличного пространства cln78\n"
TS_OID_FILE="$DBMS_ROOT/ts_cln78.oid"
TS_OID="$(psql -p 9414 -d postgres -Atc "SELECT oid FROM pg_tablespace WHERE spcname = 'cln78';")"
echo "$TS_OID" > "$TS_OID_FILE"
echo "OID cln78 сохранён: $TS_OID"

# --------------------------------------------------------------------------------------------

echo "\nПроверка доступности данных до сбоя\n"
psql -p 9414 -d wetredsoup -c "SELECT * FROM test;"

# --------------------------------------------------------------------------------------------

echo "\nСимуляция сбоя: удаление каталога WAL\n"
echo "Удаляем: $PGDATA_PRIMARY/pg_wal"
rm -rf "$PGDATA_PRIMARY/pg_wal"

echo "Пробуем сделать запрос после удаления WAL:"
psql -p 9414 -d wetredsoup -c "SELECT * FROM test;" \

echo "Пробуем перезапустить основной сервер..."
pg_ctl -D "$PGDATA_PRIMARY" stop -m fast || true
if ! pg_ctl -D "$PGDATA_PRIMARY" start; then
  echo "Сервер не смог стартовать без WAL"
fi

echo "Последние строки логов основного узла:"
ls -1t "$PGDATA_PRIMARY"/pg_log/postgresql-*.log 2>/dev/null | head -1 | xargs tail -20

echo "\nСбой смоделирован."

# --------------------------------------------------------------------------------------------

echo "\nВосстановление основного узла из резервной копии\n"

echo "Останавливаем основной сервер"
pg_ctl -D "$PGDATA_PRIMARY" stop -m immediate 2>/dev/null || true

echo "Ищем последнюю физическую резервную копию"
LATEST_BASEBACKUP="$(ls -1dt "$BACKUP_DIR"/basebackup_* 2>/dev/null | head -1 || true)"

echo "Используем резервную копию: $LATEST_BASEBACKUP"

# --------------------------------------------------------------------------------------------

echo "\nПодготовка нового расположения tablespace cln78\n"

TS_CLN78_STANDBY="$DBMS_ROOT/cln78_reserve"
TS_CLN78_RECOVER="$DBMS_ROOT/cln78_recovered"

mkdir -p "$TS_CLN78_RECOVER"
cp -a "$TS_CLN78_STANDBY/." "$TS_CLN78_RECOVER/"

# --------------------------------------------------------------------------------------------

echo "\nКопирование данных из basebackup в основной PGDATA\n"

rm -rf "$PGDATA_PRIMARY"/*
mkdir -p "$PGDATA_PRIMARY"

rsync -a "$LATEST_BASEBACKUP"/ "$PGDATA_PRIMARY"/

echo "Восстанавливаем конфиги"
cp "$DBMS_ROOT/configuration/postgresql.conf" "$PGDATA_PRIMARY/postgresql.conf"
cp "$DBMS_ROOT/configuration/pg_hba.conf" "$PGDATA_PRIMARY/pg_hba.conf"

# --------------------------------------------------------------------------------------------

echo "\nПереназначение tablespace cln78 на новый путь\n"

PG_TBLSPC_DIR="$PGDATA_PRIMARY/pg_tblspc"
mkdir -p "$PG_TBLSPC_DIR"

ln -s "$TS_CLN78_RECOVER" "$PG_TBLSPC_DIR/$TS_OID"

echo "Симлинк для cln78:"
ls -l "$PG_TBLSPC_DIR" | grep "$TS_OID"

# --------------------------------------------------------------------------------------------

echo "\nЗапуск основного узла и проверка\n"

find "$PGDATA_PRIMARY" -type d -exec chmod 0700 {} \; 2>/dev/null || true
find "$PGDATA_PRIMARY" -type f -exec chmod 0600 {} \; 2>/dev/null || true
chmod 0700 "$PGDATA_PRIMARY"

pg_ctl -D "$PGDATA_PRIMARY" start

echo "Проверка доступности сервера:"
pg_isready -p 9414 -h localhost

echo "\nПроверка данных после восстановления:"
psql -p 9414 -d wetredsoup -c "SELECT * FROM test;"

echo "\nПроверка табличных пространств:"
psql -p 9414 -d postgres -c "
SELECT spcname, pg_size_pretty(pg_tablespace_size(oid)) AS size
FROM pg_tablespace
WHERE spcname IN ('pg_default', 'pg_global', 'cln78');
"

echo "\n3 ЭТАП ЗАВЕРШЕН"
