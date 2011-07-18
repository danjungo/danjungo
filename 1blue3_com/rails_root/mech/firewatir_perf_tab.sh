#!/usr/bin/bash

# firewatir_perf_tab.sh

# Starts up jssh enabled browser.
# Then connects to browser with firewatir.
# Then logins to EM.
# Then loads the perf tab in EM.

. /rho/.rho
. /software/jruby/.jruby

set -x
cd /pt/w/em/mech/

export DISPLAY=:1
/oracle/ffoxj/mozilla-1.9.1/objdir-ff-release/dist/bin/firefox -P p10 -jssh &
sleep 11
./firewatir_login.rb &
sleep 5
./firewatir_perf_tab.rb &
echo "jssh browswer should be on perf tab now."

