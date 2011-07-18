#! /bin/bash

set -x

# get a timestamp                                                                                                                                                    
myts=`date +%Y_%m%d_%H_%M`

mkdir -p /pt/t1t/pg_dump_$myts

cd /pt/t1t/pg_dump_$myts


pg_dump -f t1t_usrs_dmp_${myts}.txt -F p --no-owner --table=usrs  --column-inserts --no-tablespaces t1t
pg_dump -f t1t_thngs_dmp_${myts}.txt -F p --no-owner --table=thngs  --column-inserts --no-tablespaces t1t
pg_dump -f t1t_tags_dmp_${myts}.txt -F p --no-owner --table=tags  --column-inserts --no-tablespaces t1t
pg_dump -f t1t_uurls_dmp_${myts}.txt -F p --no-owner --table=uurls  --column-inserts --no-tablespaces t1t
pg_dump -f t1t_frqtags_dmp_${myts}.txt -F p --no-owner --table=frqtags  --column-inserts --no-tablespaces t1t
pg_dump -f t1t_iimgs_dmp_${myts}.txt -F p --no-owner --table=iimgs  --column-inserts --no-tablespaces t1t
pg_dump -f t1t_videos_dmp_${myts}.txt -F p --no-owner --table=videos  --column-inserts --no-tablespaces t1t
pg_dump -f t1t_cmmnts_dmp_${myts}.txt -F p --no-owner --table=cmmnts  --column-inserts --no-tablespaces t1t
pg_dump -f t1t_srchs_dmp_${myts}.txt -F p --no-owner --table=srchs  --column-inserts --no-tablespaces t1t

ls -la /pt/t1t/pg_dump_$myts

# Useful syntax:
## 
## t1t=# select 'pg_dump -f t1t_'|| tablename || '_dmp.txt -F p --no-owner --table=' || tablename || '  --column-inserts --no-tablespaces t1t' from pg_tables where tableowner= 'maco';
## select 'pg_dump -f t1t_'|| tablename || '_dmp.txt -F p --no-owner --table=' || tablename || '  --column-inserts --no-tablespaces t1t' from pg_tables where tableowner= 'maco';
##                                                             ?column?                                                             
## ---------------------------------------------------------------------------------------------------------------------------------
##  pg_dump -f t1t_schema_migrations_dmp.txt -F p --no-owner --table=schema_migrations  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_usrs_dmp.txt -F p --no-owner --table=usrs  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_thngs_dmp.txt -F p --no-owner --table=thngs  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_open_id_associations_dmp.txt -F p --no-owner --table=open_id_associations  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_open_id_nonces_dmp.txt -F p --no-owner --table=open_id_nonces  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_tags_dmp.txt -F p --no-owner --table=tags  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_uurls_dmp.txt -F p --no-owner --table=uurls  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_frqtags_dmp.txt -F p --no-owner --table=frqtags  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_iimgs_dmp.txt -F p --no-owner --table=iimgs  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_videos_dmp.txt -F p --no-owner --table=videos  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_cmmnts_dmp.txt -F p --no-owner --table=cmmnts  --column-inserts --no-tablespaces t1t
##  pg_dump -f t1t_srchs_dmp.txt -F p --no-owner --table=srchs  --column-inserts --no-tablespaces t1t
## (12 rows)
## 
## t1t=# 
