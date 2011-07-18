#!/usr/bin/bash

# build.sh

# Scrapes EM to /public/s/. 
# Adds an index.html to /public/s/.
# rsyncs /public/s/ to /public/history/2009-somthing/
# Builds /public/history/index.html with /mech/add_history.rb
# rsyncs all of /public/ to web.

# oracle gives me java
. /oracle/.orcl5
# rho gives me ruby
. /rho/.rho
# firefox 352
# firefox 352 with jssh
. /oracle/ffoxj/.ffoxj
# jruby needed to screencapture
. /software/jruby/.jruby

set -x
cd /pt/w/em/mech/
./about.rb
./home.rb
# Add index.html to /public/s/.
./ts_index.rb
# screencapture performance tab
./capture_ffox.sh
# Wrap the screencapture of performance tab
./performance.rb
# Get the High Availability Console Page
./availability.rb
# rsync /public/s/ to /public/history/2009-somthing/
cd /pt/w/em/public/
# grab a timestamp for history
ts=`date +%Y_%m_%d_%H_%M`
# copy data to history
mkdir history/${ts}
/usr/bin/rsync -avz s/ history/${ts}
# Build /public/history/index.html with /mech/add_history.rb
cd /pt/w/em/mech/
./add_history.rb
# rsync all of /public/ to web.
./rsync_public.sh
