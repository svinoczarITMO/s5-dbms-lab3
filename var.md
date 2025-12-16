999

* Узел 1 — ./main (+ tablespace ./cln78)
* Узел 2 — ./reserve (+ tablespace ./cln78_reserve)
* WAL архив узла 1 - ./wal_archive
* копия WAL архива на узле 2 - ./reserve/wal_archive

# Этап 1

Дерево директорий после первого этапа:
```
.
├── backup
│   ├── basebackup_20251211_174211
│   │   ├── base
│   │   │   ├── 4
│   │   │   └── 5
│   │   ├── global
│   │   ├── pg_commit_ts
│   │   ├── pg_dynshmem
│   │   ├── pg_log
│   │   ├── pg_logical
│   │   │   ├── mappings
│   │   │   └── snapshots
│   │   ├── pg_multixact
│   │   │   ├── members
│   │   │   └── offsets
│   │   ├── pg_notify
│   │   ├── pg_replslot
│   │   ├── pg_serial
│   │   ├── pg_snapshots
│   │   ├── pg_stat
│   │   ├── pg_stat_tmp
│   │   ├── pg_subtrans
│   │   ├── pg_tblspc
│   │   ├── pg_twophase
│   │   ├── pg_wal
│   │   │   ├── archive_status
│   │   │   └── summaries
│   │   └── pg_xact
│   ├── basebackup_20251211_174929
│   │   ├── base
│   │   │   ├── 4
│   │   │   └── 5
│   │   ├── global
│   │   ├── pg_commit_ts
│   │   ├── pg_dynshmem
│   │   ├── pg_log
│   │   ├── pg_logical
│   │   │   ├── mappings
│   │   │   └── snapshots
│   │   ├── pg_multixact
│   │   │   ├── members
│   │   │   └── offsets
│   │   ├── pg_notify
│   │   ├── pg_replslot
│   │   ├── pg_serial
│   │   ├── pg_snapshots
│   │   ├── pg_stat
│   │   ├── pg_stat_tmp
│   │   ├── pg_subtrans
│   │   ├── pg_tblspc
│   │   ├── pg_twophase
│   │   ├── pg_wal
│   │   │   ├── archive_status
│   │   │   └── summaries
│   │   └── pg_xact
│   ├── basebackup_20251211_182238
│   │   ├── base
│   │   │   ├── 4
│   │   │   └── 5
│   │   ├── global
│   │   ├── pg_commit_ts
│   │   ├── pg_dynshmem
│   │   ├── pg_log
│   │   ├── pg_logical
│   │   │   ├── mappings
│   │   │   └── snapshots
│   │   ├── pg_multixact
│   │   │   ├── members
│   │   │   └── offsets
│   │   ├── pg_notify
│   │   ├── pg_replslot
│   │   ├── pg_serial
│   │   ├── pg_snapshots
│   │   ├── pg_stat
│   │   ├── pg_stat_tmp
│   │   ├── pg_subtrans
│   │   ├── pg_tblspc
│   │   ├── pg_twophase
│   │   ├── pg_wal
│   │   │   ├── archive_status
│   │   │   └── summaries
│   │   └── pg_xact
│   ├── basebackup_20251211_182724
│   │   ├── base
│   │   │   ├── 4
│   │   │   └── 5
│   │   ├── global
│   │   ├── pg_commit_ts
│   │   ├── pg_dynshmem
│   │   ├── pg_log
│   │   ├── pg_logical
│   │   │   ├── mappings
│   │   │   └── snapshots
│   │   ├── pg_multixact
│   │   │   ├── members
│   │   │   └── offsets
│   │   ├── pg_notify
│   │   ├── pg_replslot
│   │   ├── pg_serial
│   │   ├── pg_snapshots
│   │   ├── pg_stat
│   │   ├── pg_stat_tmp
│   │   ├── pg_subtrans
│   │   ├── pg_tblspc
│   │   ├── pg_twophase
│   │   ├── pg_wal
│   │   │   ├── archive_status
│   │   │   └── summaries
│   │   └── pg_xact
│   └── basebackup_20251211_183133
│       ├── base
│       │   ├── 4
│       │   └── 5
│       ├── global
│       ├── pg_commit_ts
│       ├── pg_dynshmem
│       ├── pg_log
│       ├── pg_logical
│       │   ├── mappings
│       │   └── snapshots
│       ├── pg_multixact
│       │   ├── members
│       │   └── offsets
│       ├── pg_notify
│       ├── pg_replslot
│       ├── pg_serial
│       ├── pg_snapshots
│       ├── pg_stat
│       ├── pg_stat_tmp
│       ├── pg_subtrans
│       ├── pg_tblspc
│       │   └── 16384 -> /Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/cln78_reserve
│       ├── pg_twophase
│       ├── pg_wal
│       │   ├── archive_status
│       │   └── summaries
│       └── pg_xact
├── cln78
│   └── PG_18_202506291
│       ├── 1
│       └── 16385
├── cln78_reserve
│   └── PG_18_202506291
│       ├── 1
│       └── 16385
├── configuration
├── main
│   ├── base
│   │   ├── 4
│   │   ├── 5
│   │   └── pgsql_tmp
│   ├── global
│   ├── pg_commit_ts
│   ├── pg_dynshmem
│   ├── pg_log
│   ├── pg_logical
│   │   ├── mappings
│   │   └── snapshots
│   ├── pg_multixact
│   │   ├── members
│   │   └── offsets
│   ├── pg_notify
│   ├── pg_replslot
│   ├── pg_serial
│   ├── pg_snapshots
│   ├── pg_stat
│   ├── pg_stat_tmp
│   ├── pg_subtrans
│   ├── pg_tblspc
│   │   └── 16384 -> /Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/cln78
│   ├── pg_twophase
│   ├── pg_wal
│   │   ├── archive_status
│   │   └── summaries
│   └── pg_xact
├── reserve
│   ├── base
│   │   ├── 4
│   │   └── 5
│   ├── global
│   ├── pg_commit_ts
│   ├── pg_dynshmem
│   ├── pg_log
│   ├── pg_logical
│   │   ├── mappings
│   │   └── snapshots
│   ├── pg_multixact
│   │   ├── members
│   │   └── offsets
│   ├── pg_notify
│   ├── pg_replslot
│   ├── pg_serial
│   ├── pg_snapshots
│   ├── pg_stat
│   ├── pg_stat_tmp
│   ├── pg_subtrans
│   ├── pg_tblspc
│   │   └── 16384 -> /Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/cln78_reserve
│   ├── pg_twophase
│   ├── pg_wal
│   │   ├── archive_status
│   │   └── summaries
│   ├── pg_xact
│   └── wal_archive
└── wal_archive
```

- Рассчет объема резервных копий за месяц:  
Новые данные: 800МБ + 100МБ = 900МБ в сутки  
коэф. сжатия: 25%  
итого: 450МБ / сутки  
архив WAL через месяц: ~6.5ГБ  
полная начальня копия: 64МБ
ИТОГО: ~6.5ГБ  

> С pg_basebackup через месяц: ~24ГБ (800 * 30 + 64)  
ИТОГО: ~30.5ГБ


# Этап 2
pql по порту 9415 - работает  
по порту 9414 - нет

# Этап 3
Дерево директорий после третьего этапа:
```
.
├── backup
│   ├── basebackup_20251211_174211
│   │   ├── base
│   │   │   ├── 4
│   │   │   └── 5
│   │   ├── global
│   │   ├── pg_commit_ts
│   │   ├── pg_dynshmem
│   │   ├── pg_log
│   │   ├── pg_logical
│   │   │   ├── mappings
│   │   │   └── snapshots
│   │   ├── pg_multixact
│   │   │   ├── members
│   │   │   └── offsets
│   │   ├── pg_notify
│   │   ├── pg_replslot
│   │   ├── pg_serial
│   │   ├── pg_snapshots
│   │   ├── pg_stat
│   │   ├── pg_stat_tmp
│   │   ├── pg_subtrans
│   │   ├── pg_tblspc
│   │   ├── pg_twophase
│   │   ├── pg_wal
│   │   │   ├── archive_status
│   │   │   └── summaries
│   │   └── pg_xact
│   ├── basebackup_20251211_174929
│   │   ├── base
│   │   │   ├── 4
│   │   │   └── 5
│   │   ├── global
│   │   ├── pg_commit_ts
│   │   ├── pg_dynshmem
│   │   ├── pg_log
│   │   ├── pg_logical
│   │   │   ├── mappings
│   │   │   └── snapshots
│   │   ├── pg_multixact
│   │   │   ├── members
│   │   │   └── offsets
│   │   ├── pg_notify
│   │   ├── pg_replslot
│   │   ├── pg_serial
│   │   ├── pg_snapshots
│   │   ├── pg_stat
│   │   ├── pg_stat_tmp
│   │   ├── pg_subtrans
│   │   ├── pg_tblspc
│   │   ├── pg_twophase
│   │   ├── pg_wal
│   │   │   ├── archive_status
│   │   │   └── summaries
│   │   └── pg_xact
│   ├── basebackup_20251211_182238
│   │   ├── base
│   │   │   ├── 4
│   │   │   └── 5
│   │   ├── global
│   │   ├── pg_commit_ts
│   │   ├── pg_dynshmem
│   │   ├── pg_log
│   │   ├── pg_logical
│   │   │   ├── mappings
│   │   │   └── snapshots
│   │   ├── pg_multixact
│   │   │   ├── members
│   │   │   └── offsets
│   │   ├── pg_notify
│   │   ├── pg_replslot
│   │   ├── pg_serial
│   │   ├── pg_snapshots
│   │   ├── pg_stat
│   │   ├── pg_stat_tmp
│   │   ├── pg_subtrans
│   │   ├── pg_tblspc
│   │   ├── pg_twophase
│   │   ├── pg_wal
│   │   │   ├── archive_status
│   │   │   └── summaries
│   │   └── pg_xact
│   ├── basebackup_20251211_182724
│   │   ├── base
│   │   │   ├── 4
│   │   │   └── 5
│   │   ├── global
│   │   ├── pg_commit_ts
│   │   ├── pg_dynshmem
│   │   ├── pg_log
│   │   ├── pg_logical
│   │   │   ├── mappings
│   │   │   └── snapshots
│   │   ├── pg_multixact
│   │   │   ├── members
│   │   │   └── offsets
│   │   ├── pg_notify
│   │   ├── pg_replslot
│   │   ├── pg_serial
│   │   ├── pg_snapshots
│   │   ├── pg_stat
│   │   ├── pg_stat_tmp
│   │   ├── pg_subtrans
│   │   ├── pg_tblspc
│   │   ├── pg_twophase
│   │   ├── pg_wal
│   │   │   ├── archive_status
│   │   │   └── summaries
│   │   └── pg_xact
│   ├── basebackup_20251211_183133
│   │   ├── base
│   │   │   ├── 4
│   │   │   └── 5
│   │   ├── global
│   │   ├── pg_commit_ts
│   │   ├── pg_dynshmem
│   │   ├── pg_log
│   │   ├── pg_logical
│   │   │   ├── mappings
│   │   │   └── snapshots
│   │   ├── pg_multixact
│   │   │   ├── members
│   │   │   └── offsets
│   │   ├── pg_notify
│   │   ├── pg_replslot
│   │   ├── pg_serial
│   │   ├── pg_snapshots
│   │   ├── pg_stat
│   │   ├── pg_stat_tmp
│   │   ├── pg_subtrans
│   │   ├── pg_tblspc
│   │   │   └── 16384 -> /Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/cln78_reserve
│   │   ├── pg_twophase
│   │   ├── pg_wal
│   │   │   ├── archive_status
│   │   │   └── summaries
│   │   └── pg_xact
│   └── basebackup_20251211_192714
│       ├── base
│       │   ├── 4
│       │   └── 5
│       ├── global
│       ├── pg_commit_ts
│       ├── pg_dynshmem
│       ├── pg_log
│       ├── pg_logical
│       │   ├── mappings
│       │   └── snapshots
│       ├── pg_multixact
│       │   ├── members
│       │   └── offsets
│       ├── pg_notify
│       ├── pg_replslot
│       ├── pg_serial
│       ├── pg_snapshots
│       ├── pg_stat
│       ├── pg_stat_tmp
│       ├── pg_subtrans
│       ├── pg_tblspc
│       │   └── 16384 -> /Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/cln78_reserve
│       ├── pg_twophase
│       ├── pg_wal
│       │   ├── archive_status
│       │   └── summaries
│       └── pg_xact
├── cln78
│   └── PG_18_202506291
│       ├── 1
│       └── 16385
├── cln78_recovered
│   └── PG_18_202506291
│       ├── 1
│       └── 16385
├── cln78_reserve
│   └── PG_18_202506291
│       ├── 1
│       └── 16385
├── configuration
├── main
│   ├── base
│   │   ├── 4
│   │   └── 5
│   ├── global
│   ├── pg_commit_ts
│   ├── pg_dynshmem
│   ├── pg_log
│   ├── pg_logical
│   │   ├── mappings
│   │   └── snapshots
│   ├── pg_multixact
│   │   ├── members
│   │   └── offsets
│   ├── pg_notify
│   ├── pg_replslot
│   ├── pg_serial
│   ├── pg_snapshots
│   ├── pg_stat
│   ├── pg_stat_tmp
│   ├── pg_subtrans
│   ├── pg_tblspc
│   │   └── 16384 -> /Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/cln78_recovered
│   ├── pg_twophase
│   ├── pg_wal
│   │   ├── archive_status
│   │   └── summaries
│   └── pg_xact
├── reserve
│   ├── base
│   │   ├── 4
│   │   └── 5
│   ├── global
│   ├── pg_commit_ts
│   ├── pg_dynshmem
│   ├── pg_log
│   ├── pg_logical
│   │   ├── mappings
│   │   └── snapshots
│   ├── pg_multixact
│   │   ├── members
│   │   └── offsets
│   ├── pg_notify
│   ├── pg_replslot
│   ├── pg_serial
│   ├── pg_snapshots
│   ├── pg_stat
│   ├── pg_stat_tmp
│   ├── pg_subtrans
│   ├── pg_tblspc
│   │   └── 16384 -> /Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/cln78_reserve
│   ├── pg_twophase
│   ├── pg_wal
│   │   ├── archive_status
│   │   └── summaries
│   └── pg_xact
└── wal_archive

236 directories
```

# Этап 4
```
4 ЭТАП: Логическое повреждение данных и восстановление

Пересоздание резервного узла (pg_basebackup)

waiting for server to shut down.... done
server stopped
Определяем путь tablespace cln78 на primary
pg_basebackup с tablespace-mapping:
  source TS: /Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/cln78_recovered
  target TS: /Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/cln78_reserve

Подготовка конфигурации резервного узла


Запуск standby

waiting for server to start....2025-12-15 09:50:03.017 GMT [657] LOG:  redirecting log output to logging collector process
2025-12-15 09:50:03.017 GMT [657] HINT:  Future log output will appear in directory "pg_log".
 done
server started
 pg_is_in_recovery 
-------------------
 t
(1 row)


Добавление новых данных на основном узле

INSERT 0 3
INSERT 0 3
 id |    data_value     |         created_at         
----+-------------------+----------------------------
  1 | Тестовые данные 1 | 2025-12-15 09:48:14.26111
  2 | Тестовые данные 2 | 2025-12-15 09:48:14.26111
  3 | Тестовые данные 3 | 2025-12-15 09:48:14.26111
  4 | ТЕСТОВЫЕ ДАННЫЕ 4 | 2025-12-15 09:50:03.124381
  5 | ТЕСТОВЫЕ ДАННЫЕ 5 | 2025-12-15 09:50:03.124381
  6 | ТЕСТОВЫЕ ДАННЫЕ 6 | 2025-12-15 09:50:03.124381
(6 rows)

 id | info |         updated_at         
----+------+----------------------------
  1 | А100 | 2025-12-15 09:50:03.144702
  2 | Б200 | 2025-12-15 09:50:03.144702
  3 | В300 | 2025-12-15 09:50:03.144702
(3 rows)


Фиксация времени и форсирование WAL

Время перед ошибкой: 20251215_125003
CHECKPOINT
 pg_switch_wal 
---------------
 0/60031F8
(1 row)


Ожидание, пока standby догонит primary

test primary=6 standby=6 | test2 primary=3 standby=3
 id |    data_value     |         created_at         
----+-------------------+----------------------------
  1 | Тестовые данные 1 | 2025-12-15 09:48:14.26111
  2 | Тестовые данные 2 | 2025-12-15 09:48:14.26111
  3 | Тестовые данные 3 | 2025-12-15 09:48:14.26111
  4 | ТЕСТОВЫЕ ДАННЫЕ 4 | 2025-12-15 09:50:03.124381
  5 | ТЕСТОВЫЕ ДАННЫЕ 5 | 2025-12-15 09:50:03.124381
  6 | ТЕСТОВЫЕ ДАННЫЕ 6 | 2025-12-15 09:50:03.124381
(6 rows)

 id | info |         updated_at         
----+------+----------------------------
  1 | А100 | 2025-12-15 09:50:03.144702
  2 | Б200 | 2025-12-15 09:50:03.144702
  3 | В300 | 2025-12-15 09:50:03.144702
(3 rows)


Логический дамп с резервного узла (pg_dump)

-rw-r--r--@ 1 aleksandrbabushkin  staff   5,0K 15 дек 12:50 /Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/backup/logical_backup_20251215_125003.dump

Логическое повреждение: DELETE на основном узле

ВРЕМЯ ПЕРЕД DELETE %2: 2025-12-15 12:50:03+0300
DELETE 3
 id |    data_value     |         created_at         
----+-------------------+----------------------------
  1 | Тестовые данные 1 | 2025-12-15 09:48:14.26111
  3 | Тестовые данные 3 | 2025-12-15 09:48:14.26111
  5 | ТЕСТОВЫЕ ДАННЫЕ 5 | 2025-12-15 09:50:03.124381
(3 rows)


Восстановление основного узла из дампа


Проверка восстановления

 id |    data_value     |         created_at         
----+-------------------+----------------------------
  1 | Тестовые данные 1 | 2025-12-15 09:48:14.26111
  2 | Тестовые данные 2 | 2025-12-15 09:48:14.26111
  3 | Тестовые данные 3 | 2025-12-15 09:48:14.26111
  4 | ТЕСТОВЫЕ ДАННЫЕ 4 | 2025-12-15 09:50:03.124381
  5 | ТЕСТОВЫЕ ДАННЫЕ 5 | 2025-12-15 09:50:03.124381
  6 | ТЕСТОВЫЕ ДАННЫЕ 6 | 2025-12-15 09:50:03.124381
(6 rows)

 id | info |         updated_at         
----+------+----------------------------
  1 | А100 | 2025-12-15 09:50:03.144702
  2 | Б200 | 2025-12-15 09:50:03.144702
  3 | В300 | 2025-12-15 09:50:03.144702
(3 rows)
```