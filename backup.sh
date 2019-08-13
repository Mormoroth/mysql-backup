#!/bin/bash
export WORK_DIR="/root/mysql-backups"
export USERNAME=root
export PASSWORD=PWrootPassWordPW
export DATE=$(date +%Y-%m-%d-%H-%M)
export BACKUP_DIR="/root/mysql-backups/backups/"
mkdir -p $WORK_DIR $BACKUP_DIR
innobackupex --user=$USERNAME --password=$PASSWORD --no-timestamp --stream=tar $BACKUP_DIR > ${BACKUP_DIR}${DATE}.tar.gz 2> ${WORK_DIR}/log.txt

if tail -1 "${WORK_DIR}/log.txt" | grep -i "completed OK"; then
    printf "Backup successful!\n"
    echo "Backup created at ${DATE}"
else
    echo "Backup failure! Check ${WORK_DIR}/log.txt for more information"
fi