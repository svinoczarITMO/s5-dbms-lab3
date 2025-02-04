LOCAL_BACKUP="/var/db/postgres1/restore_temp"
NEW_TABLESPACE_DIR="/var/db/postgres1/new_ipl2"
PGDATA="/var/db/postgres1/ado23"

pg_ctl -D $PGDATA stop
rm -rf "$PGDATA" "$LOCAL_BACKUP" "$NEW_TABLESPACE_DIR"
# rm restore_main.sh
# touch restore_main.sh