
hi() {
  # Show last x entries in history or search history for a character/string
  local CHAR
  if [ -n "$1" ]; then
    echo "Searching for '$1' in history..."
    history | grep --color=auto "$1"
  else
    echo "Displaying the last 10 commands"
    history | tail -n 10
  fi
}
