#!/usr/bin/bash

source common_env.sh

echo "1 ЭТАП: Резервное копирование (полная копия + WAL архивирование)\n"

WAL_SCRIPT="$DBMS_ROOT/copy_wal.sh"
MAIN_CONFIG_FILE="$PGDATA_PRIMARY/postgresql.conf"

export ARCHIVE_DIR
export STANDBY_WAL_ARCHIVE_DIR="$PGDATA_STANDBY/wal_archive"

# --------------------------------------------------------------------------------------------

echo "\nПодготовка\n"
sh ./clean.sh
mkdir -p "$PGDATA_PRIMARY" "$PGDATA_STANDBY" "$ARCHIVE_DIR" "$BACKUP_DIR" "$TS_CLN78"
mkdir -p "$STANDBY_WAL_ARCHIVE_DIR"

# --------------------------------------------------------------------------------------------

echo "\nИнициализация кластера\n"
initdb -D "$PGDATA_PRIMARY" --encoding=KOI8-R --locale=ru_RU.KOI8-R --auth-host=scram-sha-256
chmod +x "$WAL_SCRIPT"

# --------------------------------------------------------------------------------------------

echo "\nКопирование конфигов\n"
cp "$DBMS_ROOT/configuration/postgresql.conf" "$PGDATA_PRIMARY/postgresql.conf"
cp "$DBMS_ROOT/configuration/pg_hba.conf" "$PGDATA_PRIMARY/pg_hba.conf"

# --------------------------------------------------------------------------------------------

echo "\nЗапуск основного сервера\n"
pg_ctl -D "$PGDATA_PRIMARY" start

# --------------------------------------------------------------------------------------------

echo "\nSQL скрипт из ЛР2\n"
psql -p 9414 -d postgres -f "$DBMS_ROOT/script.sql"

# --------------------------------------------------------------------------------------------

echo "\nПроверка выполнения скрипта\n"
psql -p 9414 -d wetredsoup -c "\dt"
psql -p 9414 -d wetredsoup -c "SELECT * FROM test;"

# --------------------------------------------------------------------------------------------

echo "\nДемонстрация архивирования WAL\n"
echo "Параметры архивирования:"
psql -p 9414 -d postgres -c "SELECT name, setting 
FROM pg_settings 
WHERE name IN ('archive_mode','archive_command','archive_timeout','wal_level');"

echo "Принудительное переключение сегмента WAL:"
psql -p 9414 -d postgres -c "SELECT pg_switch_wal();"

echo "Проверка файлов в архиве основного узла:"
ls -la "$ARCHIVE_DIR" 2>/dev/null | head -20 || echo "Архив WAL пуст"
echo "Проверка файлов в архиве резервного узла:"
ls -la "$STANDBY_WAL_ARCHIVE_DIR" 2>/dev/null | head -20 || echo "Архив WAL на резервном узле пуст"
# --------------------------------------------------------------------------------------------

echo "\nСоздание полной резервной копии (pg_basebackup)\n"
export PGPASSWORD="${PGPASSWORD:-44}"
BASEBACKUP_DIR="$BACKUP_DIR/basebackup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BASEBACKUP_DIR"

# Так как основной и резервный узлы в моем случае иммитируются на одном хосте
# и есть пользовательское tablespace cln78,
# pg_basebackup нельзя выполнять без tablespace-mapping
TS_CLN78_STANDBY="$DBMS_ROOT/cln78_reserve"
mkdir -p "$TS_CLN78_STANDBY"
rm -rf "$TS_CLN78_STANDBY"/*

echo "Выполнение: pg_basebackup с tablespace-mapping"

pg_basebackup -h localhost -p 9414 -U aleksandrbabushkin \
  -D "$BASEBACKUP_DIR" -X stream \
  --tablespace-mapping="$TS_CLN78=$TS_CLN78_STANDBY"

# --------------------------------------------------------------------------------------------

echo "\nИмитация копирования полной копии на резервный узел (rsync)\n"
rsync -a --delete "$BASEBACKUP_DIR/" "$PGDATA_STANDBY/"
chmod 0700 "$PGDATA_STANDBY"

echo "Полная копия создана и перенесена на резервный узел"

echo "1 ЭТАП ЗАВЕРШЕН"
