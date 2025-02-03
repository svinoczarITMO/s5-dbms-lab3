#!/bin/bash

BACKUP_SOURCE="postgres1@pg184:/var/db/postgres1/backups"
LOCAL_BACKUP="/var/db/postgres1/restore_temp"
NEW_TABLESPACE_DIR="/var/db/postgres1/new_ipl2"
PGDATA="/var/db/postgres1/ado23"
PGPORT=9468

rm -rf "$PGDATA" "$LOCAL_BACKUP"
mkdir -p "$LOCAL_BACKUP" "$NEW_TABLESPACE_DIR"

rsync -av "$BACKUP_SOURCE/" "$LOCAL_BACKUP/"

initdb -D "$PGDATA" --encoding=ISO_8859_5 --locale=ru_RU.ISO8859-5 --auth-host=md5 --auth-local=peer

cp "$LOCAL_BACKUP"/conf/*.conf "$PGDATA/"

chown -R postgres1 "$NEW_TABLESPACE_DIR" "$PGDATA"
chmod 700 "$NEW_TABLESPACE_DIR" "$PGDATA"

pg_ctl -D "$PGDATA" -o "-p $PGPORT -k /tmp" start

sleep 1

gzip -dc $(ls -t "$LOCAL_BACKUP"/globals_*.sql.gz | head -1) | \
sed -e '/^\(BEGIN\|COMMIT\|START TRANSACTION\);/d' \
    -e "s|/var/db/postgres1/ipl2|$NEW_TABLESPACE_DIR|g" | \
psql -U postgres1 -p $PGPORT -d postgres


psql -U postgres1 -p $PGPORT -d postgres <<EOF
SET client_min_messages TO WARNING;
DROP DATABASE IF EXISTS coolyellowsoup;
DROP TABLESPACE IF EXISTS ipl2;
CREATE TABLESPACE ipl2 LOCATION '$NEW_TABLESPACE_DIR';
CREATE DATABASE coolyellowsoup WITH OWNER = postgres1 TABLESPACE = ipl2;
EOF

gzip -dc $(ls -t "$LOCAL_BACKUP"/full_cluster_*.sql.gz | head -1) | \
sed "s|/var/db/postgres1/ipl2|$NEW_TABLESPACE_DIR|g" | \
psql -U postgres1 -p $PGPORT -d coolyellowsoup