#!/bin/bash

BACKUP_DIR="/var/db/postgres1/backups"
PGPORT=9468

LATEST_FULL=$(ls -t $BACKUP_DIR/full_cluster_*.sql.gz | head -1)
LATEST_GLOBALS=$(ls -t $BACKUP_DIR/globals_*.sql.gz | head -1)

gzip -dc $LATEST_GLOBALS > globals.sql
gzip -dc $LATEST_FULL > full.sql

initdb -D ado23 --encoding=ISO_8859_5 --locale=ru_RU.ISO8859-5 --auth-host=md5 --auth-local=peer

cp $BACKUP_DIR/conf/*.conf ado23/

chown -R postgres1 
chmod 700 ado23

mkdir -p /var/db/postgres1/ipl2
chown postgres1 /var/db/postgres1/ipl2
chmod 700 /var/db/postgres1/ipl2

pg_ctl -D ado23 -o "-p $PGPORT -k /tmp" start

sleep 5

psql -U postgres1 -p $PGPORT -d postgres -f globals.sql
psql -U postgres1 -p $PGPORT -d postgres -c "create tablespace ipl2 location '/var/db/postgres1/ipl2';"
psql -U postgres1 -p $PGPORT -d postgres -f full.sql

echo "Восстановление завершено."