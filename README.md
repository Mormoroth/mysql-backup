# Mysql 5.x Full backup and restore using innobackupex

## Installation:

*Debian/Ubuntu:*
```bash
wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
apt-get update
apt-get install percona-xtrabackup-24
```

*RedHat/CentOS*
```bash
yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
yum list | grep percona
yum install percona-xtrabackup-24
```

## Backup:

To Backup your Mysql data run [**backup.sh**](backup.sh) . Just remember to change directories
to your preferable destination. Also set mysql root password.
This script only archive last two backup of your database each time you run it.
It is also possible to run it with cronjob; For instance:
```bash
0 */12 * * * . /root/backup.sh
```
```bash
chmod +x backup.sh
./backup.sh
```
With successful backup you will be notified with message : **Backup successful!**
## Restore:

To restore backup first stop mysql service
```bash
systemctl mysql stop
```
Then we have to extract backup tarball
```bash
mkdir -p /root/restore
mv /root/mysql-backups/backups/2019-08-14-12-00.tar.gz /root/restore/2019-08-14-12-00.tar.gz
cd /root/restore/ && xf 2019-08-14-12-00.tar.gz
```
Now we should apply logs.
```bash
innobackupex --use-memory=2G --apply-log /root/restore
```
It will show you **innobackupex: completed OK!** if process is compeleted as planned.
Restoration will copy data to you *datadir* in your **my.cnf**
To start restoration run:
```bash
innobackupex --copy-back /root/restore
```
Set proper permision and start mysql again.
```bash
chown -R mysql:mysql /var/lib/mysql
systemctl mysql start
```