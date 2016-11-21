
# List processes of a user
psu()
{
  if [ -n "$1" ]; then
    ps -u $USER -U $USER | grep $1
  else
    ps -u $USER -U $USER
  fi
}
export -f psu


# List working directories of processes of a user
psux()
{
  if [ -n "$1" ]; then
    PIDS=$(ps -u $USER -U $USER -o pid= -o comm= | grep $1 | awk '{ print $1 }')
    for PID in $PIDS; do
      pwdx $PID
    done
  else
    PIDS=$(ps -u $USER -U $USER -o pid= -o comm= |            awk '{ print $1 }')
    for PID in $PIDS; do
      pwdx $PID
    done
  fi
}
