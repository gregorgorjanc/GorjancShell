

psu() {
  # List processes of a user
  # $1 process name (if not given, list all processes)
  if [ -n "$1" ]; then
    ps -u "$USER" -U "$USER" | grep --color=auto "$1"
  else
    ps -u "$USER" -U "$USER"
  fi
}

psux() {
  # List working directories of processes of a user
  # $1 process name (if not given, list all processes)
  local PIDS PID
  if [ -n "$1" ]; then
    PIDS=$(ps -u "$USER" -U "$USER" -o pid=,comm= | grep "$1" | awk '{print $1}')
  else
    PIDS=$(ps -u "$USER" -U "$USER" -o pid= | awk '{print $1}')
  fi
  for PID in $PIDS; do
    pwdx "$PID"
  done
}
