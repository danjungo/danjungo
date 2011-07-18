#! /bin/sh
# /pt/w/e4/e11/script/pg_dump_e11p.sh
set -x

  cd /pt/w/e4/e11/db/
  filename=/pt/w/e4/e11/db/e11p_dmp_`date +%Y_%m_%d_%H_%M`
  pg_dump -f ${filename}_rpts.sql          -F p -v --no-owner  --column-inserts --table=rpts            e11p
  pg_dump -f ${filename}_rpttypes.sql      -F p -v --no-owner  --column-inserts --table=rpttypes        e11p
  pg_dump -f ${filename}_symbls.sql        -F p -v --no-owner  --column-inserts --table=symbls          e11p
  pg_dump -f ${filename}_usrs.sql          -F p -v --no-owner  --column-inserts --table=usrs            e11p
  pg_dump -f ${filename}_bcrmbs.sql        -F p -v --no-owner  --column-inserts --table=bcrmbs          e11p
  pg_dump -f ${filename}_exprtypes.sql     -F p -v --no-owner  --column-inserts --table=exprtypes       e11p
  pg_dump -f ${filename}_frgmnts.sql       -F p -v --no-owner  --column-inserts --table=frgmnts         e11p
  pg_dump -f ${filename}_outputrpts.sql    -F p -v --no-owner  --column-inserts --table=outputrpts      e11p
  pg_dump -f ${filename}_outputrpttypes.sql -F p -v --no-owner  --column-inserts --table=outputrpttypes e11p

  gzip ${filename}*
  echo "done at"
  date












