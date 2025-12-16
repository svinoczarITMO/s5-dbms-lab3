#!/usr/bin/bash

set -euo pipefail

pg_ctl -D "$PGDATA_PRIMARY" stop -m immediate 2>/dev/null || true

LATEST_BASEBACKUP="$(ls -1dt "$BACKUP_DIR"/basebackup_* | head -1)" 

rsync -a "$LATEST_BASEBACKUP"/ "$PGDATA_PRIMARY"/

chmod 0700 "$DBMS_ROOT/error_time_pitr.txt"

RECOVERY_TARGET_TIME="$(cat "$DBMS_ROOT/error_time_pitr.txt")"

echo "\n
# ---------------------------------------------
restore_command = 'cp $ARCHIVE_DIR/%f %p'
recovery_target_time = '$RECOVERY_TARGET_TIME'
recovery_target_action = 'promote'
# ---------------------------------------------
" >> "$PGDATA_PRIMARY/postgresql.conf"

touch "$PGDATA_PRIMARY/recovery.signal"

chmod 0700 $PGDATA_PRIMARY

pg_ctl -D "$PGDATA_PRIMARY" start

psql -p 9414 -d "wetredsoup" -c "SELECT * FROM test ORDER BY id;"
