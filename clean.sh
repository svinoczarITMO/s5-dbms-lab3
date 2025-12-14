#!/bin/bash
source common_env.sh

DBMS_ROOT="/Users/aleksandrbabushkin/ITMO/s7-dbms-lab3"
PGDATA_PRIMARY="$DBMS_ROOT/main"
PGDATA_STANDBY="$DBMS_ROOT/reserve"
ARCHIVE_DIR="$DBMS_ROOT/wal_archive"
BACKUP_DIR="$DBMS_ROOT/backup"
TS_CLN78="$DBMS_ROOT/cln78"

stop_all_servers

rm -rf "$PGDATA_PRIMARY"
rm -rf "$PGDATA_STANDBY"
rm -rf "$ARCHIVE_DIR"
rm -rf "$BACKUP_DIR"
rm -rf "$STANDBY_WAL_ARCHIVE_DIR"
rm -rf "$TS_CLN78"
rm -rf "$DBMS_ROOT/cln78_reserve"
rm -rf "$DBMS_ROOT/cln78_recovered"
rm -rf *.oid