#!/usr/bin/bash
# /pt/w/em/mech/rsync_public.sh

# Uses rsync to copy public/ from point a to point b
set -x

# cd to the right place
cd /pt/w/em/public/

/usr/bin/rsync -e '/usr/bin/ssh -p 8822' -avz /pt/w/1blue3/em10/public oracle@i:/pt/w/1blue3/em10
