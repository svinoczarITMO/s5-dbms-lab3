#!/bin/bash

# Устанавливаем текущую дату для резервной копии
CURRENT_DATE=$(date "+%Y-%m-%d_%H:%M:%S")

# Создаем полную резервную копию с сжатием
pg_dump -U postgres1 -d coolyellowsoup -p 9468 | gzip > ~/backups/backup_$CURRENT_DATE.sql.gz

BACKUP_FILE=~/backups/backup_$CURRENT_DATE.sql.gz

# Перемещаем резервную копию на резервный узел
scp "$BACKUP_FILE" postgres1@pg184:~/backups/

# Удаляем резервные копии старше 28 дней на резервном узле
ssh postgres1@pg184 'find ~/backups/ -type f -mtime +28 -exec rm -f {} \;'
