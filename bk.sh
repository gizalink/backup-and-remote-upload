#!/bin/bash

date=$(date +"%d-%b-%Y_%H_%M")

USER="User DB or User Hosting"
PASSWORD="Password user db or password user hosting"
path_bk="/home/user/backuponly" #Path location folder keep file backup


mkdir $path_bk/db
cd public_html #Cd to folder backup

for i in *; do tar -czf $i.tar.gz $i;  mv $i.tar.gz $path_bk; done #Compress subfolder to file zip and move to folder keep backup

#Or tar -czf backup.tar.gz folderwantbackup; mv backup.tar.gz $path_bk;

#Export All Database on Hosting
databases=`mysql -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump -u $USER -p$PASSWORD --databases $db > $path_bk/db/`date +%Y%m%d`.$db.sql
    fi
done

tar -czf $path_bk/db.tar.gz -P $path_bk/db
cd $path_bk
php -f ftp_transfer.php
rm -rf db/
echo 'Done'
