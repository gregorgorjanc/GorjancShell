
remove_header() {
  # Remove header from a file
  # $1 input file
  local n
  n=$(wc -l < "$1" | awk '{ print $1 }')
  ((n--))
  # let n=$n-1
  tail -n "$n" "$1"
}