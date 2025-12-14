#!/bin/bash
# common_env.sh
export DBMS_ROOT="/Users/aleksandrbabushkin/ITMO/s7-dbms-lab3"
export PGDATA_PRIMARY="$DBMS_ROOT/main"
export PGDATA_STANDBY="$DBMS_ROOT/reserve"
export ARCHIVE_DIR="$DBMS_ROOT/wal_archive"
export BACKUP_DIR="$DBMS_ROOT/backup"
export TS_CLN78="$DBMS_ROOT/cln78"

# Функция для остановки всех серверов
stop_all_servers() {
    pg_ctl -D "$PGDATA_PRIMARY" stop -m fast 2>/dev/null || true
    pg_ctl -D "$PGDATA_STANDBY" stop -m fast 2>/dev/null || true
}