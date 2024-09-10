# -path and * in string add possibilty to find files like .bashrc

findf() {
  # Find file or files, directories and links given as first parameter
  # $* files, directories, links or strings
  local NAME USAGE STRING
  NAME='findf'
  USAGE="$NAME file1 [file2 ...]"
  if [ -n "$1" ]; then
    for STRING in "$@"; do
      eval find . -type f | grep $STRING
    done
  else
    echo "Missing argument!"
    echo "Usage: $USAGE"
  fi
}

findd() {
  # Find directories given as first parameter
  # $* directories or strings
  local NAME USAGE STRING
  NAME='findd'
  USAGE="$NAME dir1 [dir2 ...]"
  if [ -n "$1" ]; then
    for STRING in "$@"; do
      eval find . -type d | grep $STRING
    done
  else
    echo "Missing argument!"
    echo "Usage: $USAGE"
  fi
}

findl() {
  # Find symbolic links given as first parameter
  # $* links or strings
  local STRING NAME
  NAME='findl'
  USAGE="$NAME link1 [link2 ...]"
  if [ -n "$1" ]; then
    for STRING in "$@"; do
      eval find . -type l | grep $STRING
    done
  else
    echo "Missing argument!"
    echo "Usage: $USAGE"
  fi
}