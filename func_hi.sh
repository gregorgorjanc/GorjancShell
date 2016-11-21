
# HISTORY
#-----------------------------------------------------------------------------

# Show last x entries
# My-time-stamp: <2004-12-29 01:18:00 GGorjan>
hi()
{
  local CHAR
  if [ -n "$1" ]; then
    echo "Searching for character"
    history | grep $1
  else
    echo "Displaying last 10 commands"
    history | tail -n 10
  fi
}
export -f hi
