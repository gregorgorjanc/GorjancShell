
browse() {
  # Launch file browser
  # $@ folders to browse/open - by default its current folder
  if [ "$(uname)" = "Darwin" ]; then
    if [ $# -eq 0 ]; then
      /usr/bin/open . &
    else
      /usr/bin/open "$@" &
    fi
  fi
}
