#!/bin/sh
#
# $FreeBSD: ports/www/lighttpd/files/lighttpd.sh.in,v 1.1 2005/08/29 10:13:32 garga Exp $
#

# PROVIDE: lighttpd
# REQUIRE: DAEMON
# BEFORE: LOGIN
# KEYWORD: FreeBSD shutdown

#
# Add the following lines to /etc/rc.conf to enable lighttpd:
#
#lighttpd_enable="YES"
#
# See lighttpd(1) for manual
#

. /etc/rc.subr

name=lighttpd
rcvar=`set_rcvar`

# command=/usr/local/sbin/lighttpd
command=/home/oracle/l/sbin/lighttpd
pidfile=/var/run/ssl_lighttpd.forumgrouper.pid
required_files=${lighttpd_conf}

stop_postcmd=stop_postcmd

stop_postcmd()
{
  rm -f $pidfile
}

# set defaults

lighttpd_enable=${lighttpd_enable:-"NO"}
lighttpd_conf=${lighttpd_conf:-"/pt/w/fg/fg12/config/ssl_lighttpd_fg12_hosthead.conf"}

load_rc_config $name

command_args="-f ${lighttpd_conf}"
run_rc_command "$1"
