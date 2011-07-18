#!/bin/sh
myts=`date +%Y_%m_%d_%H_%M`

# mysqldump -F -u c1cme2 -p --socket=/var/lib/mysql/mysql.sock  --result-file=c1cme2_mysqldump${myts}.txt --database c1cme2

# mysqldump -p --skip-opt -F -u c1cme2 -S /var/lib/mysql/mysql.sock -r c1cme2_mysqldump${myts}.txt c1cme2

mysqldump -F -u c1cme -p --socket=/var/lib/mysql/mysql.sock  --result-file=c1cme_mysqldump${myts}.txt --database c1cme
