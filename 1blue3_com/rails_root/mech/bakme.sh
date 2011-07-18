#!/usr/bin/bash
# bakme.sh
# cd to the right place
set -x
cd /pt/

# get a timestamp
ts=`date +%Y_%m_%d_%H_%M`

# Use tar
tar zcf /bak/pt_w_1blue3_${ts}.tgz w/1blue3

echo "scp  /bak/pt_w_1blue3_${ts}.tgz maco@mac3:bak/"
echo "scp  /bak/pt_w_1blue3_${ts}.tgz s:/u2/bak/"

# done
