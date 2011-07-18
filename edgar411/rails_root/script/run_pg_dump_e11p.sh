#! /bin/sh

# /pt/w/e4/e11/script/run_pg_dump_e11p.sh

# Intended to be run on mac from cron to copy table data off server to mac.

set -x

# cd to the right place
cd /pt/w/e4/e11/db/

ssh oracle@hh /pt/w/e4/e11/script/pg_dump_e11p.sh

scp -p oracle@hh:/pt/w/e4/e11/db/e11p\*z .

tar  zcf e11p_dmp_`date +%Y_%m_%d_%H_%M`.tgz e11*sql.gz

rm e11*sql.gz

echo "done at"
date
