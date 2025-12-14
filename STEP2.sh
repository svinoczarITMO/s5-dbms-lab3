#!/usr/bin/bash

echo "2 ЭТАП: Потеря основного узла (failover)\n"
echo "Сценарий: основной узел недоступен, поднимаем резервный как новый основной\n"

export ARCHIVE_DIR
export STANDBY_WAL_ARCHIVE_DIR="$PGDATA_STANDBY/wal_archive"

WAL_SCRIPT="$DBMS_ROOT/copy_wal.sh"
RESERVE_CONFIG_FILE="$PGDATA_STANDBY/postgresql.conf"

# --------------------------------------------------------------------------------------------

echo "Остановка резервного сервера, если запущен\n"
pg_ctl -D "$PGDATA_STANDBY" stop -m fast 2>/dev/null || true

# --------------------------------------------------------------------------------------------

echo "Подготовка конфигурации резервного узла\n"

# меняем порт
sed -i '' -E "s#^[[:space:]]*port[[:space:]]*=.*#port = 9415#g" "$RESERVE_CONFIG_FILE"

# убираем standby-режим
rm -f "$PGDATA_STANDBY/standby.signal"

chmod 0700 "$PGDATA_STANDBY"

# --------------------------------------------------------------------------------------------

echo "Симуляция потери основного узла\n"
pg_ctl -D "$PGDATA_PRIMARY" stop -m immediate 2>/dev/null || true

# --------------------------------------------------------------------------------------------

echo "Запуск резервного узла как нового основного\n"
pg_ctl -D "$PGDATA_STANDBY" start

echo "Проверка доступности нового основного\n"
pg_isready -p 9415 -h localhost

# --------------------------------------------------------------------------------------------

echo "\nПроверка данных на новом основном\n"

echo "Список баз данных:"
psql -p 9415 -d postgres --pset=pager=off -c "\l"

echo "\nТаблица test:"
psql -p 9415 -d wetredsoup -c "SELECT * FROM test;"

echo "\nТабличные пространства:"
psql -p 9415 -d postgres -c "
SELECT t.spcname, pg_size_pretty(pg_tablespace_size(t.oid)) AS size
FROM pg_tablespace t;
"

echo "\n2 ЭТАП ЗАВЕРШЕН"
echo "Основной узел остановлен, резервный запущен как новый основной на порту 9415"