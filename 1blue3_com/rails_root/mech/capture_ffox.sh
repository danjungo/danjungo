#!/usr/bin/bash

# capture_ffox.sh

# screen captures firefox
export DISPLAY=:1
# Get a copy of the screen into /tmp/screencapture.png
jruby capture_ffox.rb
# Copy it to a place which leads to publication
cp /tmp/screencapture.png ../public/s/performance/


