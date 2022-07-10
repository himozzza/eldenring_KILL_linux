#!/bin/bash

stop_flag=true
while $stop_flag == true;
do
    /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/steam-wrapper com.valvesoftware.Steam steam://rungameid/1245620 &
    sleep 30
    pid_id=`ps aux | grep -i eldenring.exe | grep -v grep | awk '{print $2}'`
    memory_kb=`cat /proc/$pid_id/status | grep -i vmhwm | awk '{print $2}' 2> /dev/null`
    memory_mb=$(( $memory_kb / 1024 ))
    if (( $memory_mb < 1000 ));
    then
        kill -9 $pid_id 2> /dev/null
        sleep 2
    else
        wait $pid_id
        stop_flag=false
    fi
done