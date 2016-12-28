# alarm-clock.sh
# ==============
#
# Description:
# ============
#   This program will use spotify software as a alarm-clock.
#
# Developer:
# ==========
#   Luiz Antonio Marques Ferreira.
#
# References:
# ===========
#   [1]: https://github.com/mkscrg/alarm-clock
#   [2]: https://github.com/hnarayanan/shpotify

#!/bin/bash

set_hour_to_sec() {
    # This function will convert the hour to seconds, based on [1] and [2]
    # @arg: clock, in date format HH:MM:SS
    # @return, convert arg clock in seconds

    # Set argument time
    clock="$1"

    # Separate hour, min and sec from time
    clock_h=`echo $clock | awk -F: '{print $1}'`
    clock_m=`echo $clock | awk -F: '{print $2}'`
    clock_s=`echo $clock | awk -F: '{print $3}'`

    # Convert clock to seconds
    clock_s_t=`dc -e "$clock_h 60 60 ** $clock_m 60 * $clock_s ++p"`
}

alarm() {
    # Function to active the alarm-clock, based on [1]

    # Set alarm hour
    echo "Digite as horas que você deseja acordar (HH:MM:SS):"
    read alarm_hour
    set_hour_to_sec $alarm_hour
    alarm_hour_in_sec=$clock_s_t
    
    # Get current time
    set_hour_to_sec $(date +%T)
    current_hour_in_sec=$clock_s_t

    # Start alarm on time
    time_to_start_alarm=`dc -e "24 60 60 **d $alarm_hour_in_sec $current_hour_in_sec -+r%p"`
    sleep $time_to_start_alarm
    echo "Hora de acordar!!!"

    # Play spotify with volum at 20%
    spotify play
    spotify vol 20
    
    # In each 5 minutes, set up the volum in 10%
    while true; do
	sleep 60
	spotify play
	spotify vol up

	# Interrupt key
	# TODO
    done
    
}

alarm
