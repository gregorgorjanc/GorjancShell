
rows() {
  # Print out a few rows of a file
  # $1 starting row
  # $2 ending row
  # $3 file
  local nr=$(wc -l < "$3")
  local d=$(( $2 - $1 + 1 ))
  if [[ $1 -gt 0 && $2 -le $nr ]]; then
    head -n $2 "$3" | tail -n $d
  else
    echo "Error: Row range out of bounds. File $3 has $nr rows."
  fi
}

cols() {
  # Print out a few columns of a file
  # $1 starting row
  # $2 ending row
  # $3 file
  # $4 separator
  local sep=${4:-" "} # Use space as default separator if $4 is empty
  cut -d "$sep" -f"$1"-"$2" "$3"
}
