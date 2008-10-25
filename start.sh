#!/bin/sh
#
# Daemontools-like startup script

exec > embot.log
exec 2>&1

while :
do
	ruby embot.rb
	sleep 5
done
