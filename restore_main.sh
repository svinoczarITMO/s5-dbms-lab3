#!/bin/bash

BACKUP_SOURCE="postgres1@pg184:/var/db/postgres1/backups"
LOCAL_BACKUP="/var/db/postgres1/restore_temp"
NEW_TABLESPACE_DIR="/var/db/postgres1/new_ipl2"
PGDATA="/var/db/postgres1/ado23"
PGPORT=9468

# Очистка старых данных
rm -rf "$PGDATA" "$LOCAL_BACKUP"
mkdir -p "$LOCAL_BACKUP" "$NEW_TABLESPACE_DIR"

# Копирование бэкапов с удаленного узла
rsync -av "$BACKUP_SOURCE/" "$LOCAL_BACKUP/"

# Инициализация нового кластера
initdb -D "$PGDATA" --encoding=ISO_8859_5 --locale=ru_RU.ISO8859-5 --auth-host=md5 --auth-local=peer

# Восстановление конфигурации
cp "$LOCAL_BACKUP"/conf/*.conf "$PGDATA/"

# Настройка прав
chown -R postgres1 "$NEW_TABLESPACE_DIR" "$PGDATA"
chmod 700 "$NEW_TABLESPACE_DIR" "$PGDATA"

# Запуск кластера
pg_ctl -D "$PGDATA" -o "-p $PGPORT -k /tmp" start
sleep 5

# Восстановление глобальных объектов (без транзакций)
gzip -dc $(ls -t "$LOCAL_BACKUP"/globals_*.sql.gz | head -1) | \
sed -e '/^\(BEGIN\|COMMIT\|START TRANSACTION\);/d' \
    -e "s|'/var/db/postgres1/ipl2'|'$NEW_TABLESPACE_DIR'|g" | \
psql -U postgres1 -p $PGPORT -d postgres -v ON_ERROR_STOP=1

# Принудительное создание табличного пространства и БД (вне транзакции)
psql -U postgres1 -p $PGPORT -d postgres -c "
DROP DATABASE IF EXISTS coolyellowsoup;
DROP TABLESPACE IF EXISTS ipl2;
CREATE TABLESPACE ipl2 LOCATION '$NEW_TABLESPACE_DIR';
CREATE DATABASE coolyellowsoup TABLESPACE ipl2;
"

# Восстановление данных с заменой путей
gzip -dc $(ls -t "$LOCAL_BACKUP"/full_cluster_*.sql.gz | head -1) | \
sed "s|/var/db/postgres1/ipl2|$NEW_TABLESPACE_DIR|g" | \
psql -U postgres1 -p $PGPORT -d coolyellowsoup -v ON_ERROR_STOP=1

# Проверка
echo "Проверка расположения БД:"
psql -U postgres1 -p $PGPORT -d postgres -c "\l+ coolyellowsoup"

echo "Проверка табличных пространств:"
psql -U postgres1 -p $PGPORT -d coolyellowsoup -c "SELECT spcname, pg_tablespace_location(oid) FROM pg_tablespace"
