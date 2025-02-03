#!/bin/bash

DB_USER="postgres1"
BACKUP_DIR="/var/db/postgres1/db_backups"
REMOTE_HOST="postgres1@pg184"
REMOTE_DIR="/var/db/postgres1/backups"
RETENTION_DAYS=28
PGPORT=9468
DATE=$(date +%Y-%m-%d)
CONF_DIR="$HOME/conf"
 
pg_dumpall -U "$DB_USER" -p $PGPORT --globals-only | gzip > "$BACKUP_DIR/globals_$DATE.sql.gz"

pg_dumpall -U "$DB_USER" -p $PGPORT | gzip > "$BACKUP_DIR/full_cluster_$DATE.sql.gz"

cp -r "$CONF_DIR" "$BACKUP_DIR/conf/"

psql -U "$DB_USER" -p $PGPORT -d postgres -c "\db+" > "$BACKUP_DIR/tablespaces_meta_$DATE.txt"

rsync -av --remove-source-files "$BACKUP_DIR/" "${REMOTE_HOST}:${REMOTE_DIR}/"

ssh "${REMOTE_HOST}" "find ${REMOTE_DIR} -type f -name '*.gz' -mtime +${RETENTION_DAYS} -delete"