#!/bin/bash

DB_NAME="coolyellowsoup"
DB_USER="postgres1"
DB_HOST="127.0.0.1"
BACKUP_DIR="/var/db/postgres1/db_backups"
REMOTE_HOST="postgres1@pg184"
REMOTE_DIR="/var/db/postgres1/backups"
RETENTION_DAYS=28
mkdir -p "$BACKUP_DIR"
DATE=$(date +%Y-%m-%d)
DUMP_FILE="${DB_NAME}_backup_${DATE}.sql.gz"
pg_dump -U "$DB_USER" "$DB_NAME" -p 9468 | gzip > "${BACKUP_DIR}/${DUMP_FILE}"
rsync -av --remove-source-files "${BACKUP_DIR}/${DUMP_FILE}" "${REMOTE_HOST}:${REMOTE_DIR}"
ssh "${REMOTE_HOST}" "find ${REMOTE_DIR} -type f -name '*.sql.gz' -mtime +${RETENTION_DAYS} -delete"
