#! /bin/sh

# run_pg_dump_hp12p.sh

# Intended to be run on mac from cron to copy table data off server to mac.

set -x

# cd to the right place
cd /pt/w/hp/hp12/db/

ssh oracle@hh /pt/w/hp/hp12/script/pg_dump_hp12p.sh

scp -p oracle@hh:/pt/w/hp/hp12/db/hp12p\*z .

tar  zcf hp12p_dmp_`date +%Y_%m_%d_%H_%M`.tgz hp12*sql.gz

rm hp12*sql.gz

echo "done at"
date


