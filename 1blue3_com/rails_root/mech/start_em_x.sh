#!/usr/bin/bash
# /pt/w/em/mech/start_em_x.sh
# See:
# # http://www.semicomplete.com/blog/geekery/xvfb-firefox.html
# tightvnc

# This starts an X-server which then allows me to run ffox.
# Also I can then vnc to it.
/usr/bin/tightvncserver -nolisten tcp :1


