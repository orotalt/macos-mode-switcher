#!/usr/bin/env bash


SUNRISE="$(curl -s  $(locateme -f "http://api.sunrise-sunset.org/json?lat={LAT}&lng={LON}") | jq '.results.sunrise')"
SUNSET="$(curl -s  $(locateme -f "http://api.sunrise-sunset.org/json?lat={LAT}&lng={LON}") | jq '.results.sunset')"


hour(){
    echo $1 |tr -d '"'| cut -f1 -d:
}
min(){
    echo $1 tr -d '"'| cut -f2 -d:
}


initCrontab(){
    printf "%d %d * * * bash \"%s\" 2>/dev/null \n" $(hour ${SUNRISE}) $(min ${SUNRISE}) $0 
    printf "%d %d * * * bash \"%s\" 2>/dev/null \n" $(hour ${SUNSET}) $(min ${SUNSET})   $0
}

main(){
    if [[ ${1} == "crontab" ]]; then
       initCrontab
    else osascript << EOF
tell application "System Events"
tell appearance Preferences
set dark mode to not dark mode
end tell
end tell
EOF
    fi
    
     
}

main $1
