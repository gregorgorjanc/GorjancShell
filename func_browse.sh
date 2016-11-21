
# --- File browser(s) ---

browse()
{
  if [ $(uname) == Darwin ]; then
    if [ $# == 0 ]; then
      /usr/bin/open . &
    else
      /usr/bin/open $* &
    fi
  fi
}
export -f browse
