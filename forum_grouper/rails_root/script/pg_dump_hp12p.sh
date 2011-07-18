#! /bin/sh
# /pt/w/hp/hp12/script/pg_dump_hp12p.sh
set -x

  cd /pt/w/fg/
  filename=/pt/w/fg/fg12/db/fg11p_dmp_`date +%Y_%m_%d_%H_%M`
  pg_dump -f ${filename}_gcategs.sql -F p -v --no-owner  --column-inserts --table=gcategs fg11p
  pg_dump -f ${filename}_grps.sql    -F p -v --no-owner  --column-inserts --table=grps fg11p
  pg_dump -f ${filename}_frms.sql    -F p -v --no-owner  --column-inserts --table=frms fg11p
  pg_dump -f ${filename}_usrs.sql    -F p -v --no-owner  --column-inserts --table=usrs fg11p
  pg_dump -f ${filename}_prsnas.sql  -F p -v --no-owner  --column-inserts --table=prsnas fg11p
  pg_dump -f ${filename}_psts.sql    -F p -v --no-owner  --column-inserts --table=psts fg11p
  gzip ${filename}*
  echo "done at"
  date


