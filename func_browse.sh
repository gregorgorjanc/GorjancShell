
# --- File browser(s) ---

browse() {
  if [ "$(uname)" = "Darwin" ]; then
    if [ $# -eq 0 ]; then
      /usr/bin/open . &
    else
      /usr/bin/open "$@" &
    fi
  fi
}
