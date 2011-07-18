#! /bin/sh
# /pt/w/hp/hp12/script/pg_dump_hp12p.sh
set -x

  cd /pt/w/hp/
  filename=/pt/w/hp/hp12/db/hp12p_dmp_`date +%Y_%m_%d_%H_%M`
  pg_dump -f ${filename}_frgmnts.sql -F p -v --no-owner  --column-inserts --table=frgmnts hp12p
  pg_dump -f ${filename}_exprtypes.sql -F p -v --no-owner  --column-inserts --table=exprtypes hp12p
  pg_dump -f ${filename}_stcks.sql -F p -v --no-owner  --column-inserts --table=stcks hp12p
  pg_dump -f ${filename}_usrs.sql -F p -v --no-owner  --column-inserts --table=usrs hp12p
  gzip ${filename}*
  echo "done at"
  date


