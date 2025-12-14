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
