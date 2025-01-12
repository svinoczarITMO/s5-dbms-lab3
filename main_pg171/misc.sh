ssh-keygen -t rsa -b 4096 -C "postgres1@pg171"
ssh-copy-id -i ~/.ssh/id_rsa.pub postgres1@pg184
mkdir -p ~/backups
scp -o "ProxyJump s367845@se.ifmo.ru:2222" main_pg171/backup.sh postgres1@pg171:~
chmod +x backup.sh
crontab -e
0 2 * * 0 ~/backup.sh >> ~/backup.log 2>&1

/tmp/crontab.RwA6Ex9ZTM: 1 строк, 43 символов.
crontab: installing new crontab