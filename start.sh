#!/bin/sh
#
# Daemontools-like startup script

exec > bot.log
exec 2>&1

while :
do
	ruby bot.rb
	sleep 5
done
