#!/usr/bin/env bash
set -euo pipefail

WAL_FILE="${1:-}"
[ -z "$WAL_FILE" ] && exit 1

ARCHIVE_DIR="${ARCHIVE_DIR:-/tmp/wal_archive}"
STANDBY_WAL_ARCHIVE_DIR="${STANDBY_WAL_ARCHIVE_DIR:-/tmp/wal_archive_standby}"

mkdir -p "$ARCHIVE_DIR" "$STANDBY_WAL_ARCHIVE_DIR"

WAL_NAME="$(basename "$WAL_FILE")"

cp "$WAL_FILE" "$ARCHIVE_DIR/$WAL_NAME"
cp "$WAL_FILE" "$STANDBY_WAL_ARCHIVE_DIR/$WAL_NAME"

echo "$(date '+%Y-%m-%d %H:%M:%S'): скопирован $WAL_NAME" >> "$ARCHIVE_DIR/wal_copy.log"
