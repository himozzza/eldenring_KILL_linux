#!/bin/bash

attempts=1
stop_flag=true
while [ $stop_flag = true ];
do
    /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/steam-wrapper com.valvesoftware.Steam steam://rungameid/1245620 &
    sleep 30
    pid_id=$(pgrep -f eldenring.exe)
    memory_kb=$(grep -i vmhwm /proc/"$pid_id"/status | awk '{print $2}' 2> /dev/null)
    memory_mb=$(( memory_kb / 1024 ))
    if (( memory_mb < 1000 ));
    then
        kill -9 "$pid_id" 2> /dev/null
        sleep 2
        ((attempts++))
    else
        echo -ne "$(date +%F%t%T)\nИгра запущена с $attempts раза.\n\n" >> /home/"$USER"/EldenRing.log
        stop_flag=false
    fi
done
exit 0
