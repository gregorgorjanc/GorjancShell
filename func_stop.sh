
# STOP
#-------------------------------------------------------------------------------

# Shutdown the machine with simple command. Needs user confirmation and
# user privilege to shutdown command via 'sudo'.

# Usage: stop

# My-time-stamp: <2003-11-16 08:56:00 ggorjan>

stop()
{
    local NAME YORN
    NAME=stop
    echo -e 'Are you sure to shutdown the machine (y/N)? \c'
    read YORN
    if [ $YORN == y ]; then
        if [ -f ${HOME}/.onStop.sh ]; then
            source ${HOME}/.onStop.sh
        fi
        echo
        echo 'Gooing to sleep .... bz ... :)'
        echo
        sudo shutdown -h now
    else
        echo 'OK, some other time.'
    fi
}
export -f stop

# REBOOT
#-------------------------------------------------------------------------------

# Reboot the machine with simple command via 'sudo'. Needs user
# confirmation.

# Usage: reboot

# My-time-stamp: <2003-11-16 08:56:00 ggorjan>

reboot()
{
    local NAME YORN
    NAME=reboot
    echo -e 'Are you sure to reboot the machine (y/N)? \c'
    read YORN
    if [ $YORN == y ]; then
        echo
        echo 'Rebooting ...'
        echo
        sudo /sbin/reboot
    else
        echo 'OK, some other time.'
    fi
}
export -f reboot
