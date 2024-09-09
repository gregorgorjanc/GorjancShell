
dim() {
  # Count the number of rows in file(s) and columns in file(s) header
  # $1 $2 = potentially a delimiter, i.e., -d ,
  # (these two arguments are optional and -d must be the first)
  # $@ = file names
  local DELIM FILE NROW NCOL
  if [[ $1 == "-d" ]]; then
    DELIM=$2
    shift 2
  else
    DELIM=" "
  fi
  # echo "DELIM is |$DELIM|"
  # echo "args are $@"
  for FILE in "$@"; do
    NROW=$(wc -l "$FILE" | awk '{ print $1 }')
    NCOL=$(head -n 1 "$FILE" | awk -F "$DELIM" '{ print NF }')
    echo "$NROW $NCOL $FILE"
    unset NROW NCOL
  done
}

nrow() {
  # Count the number of rows in file(s)
  # $@ = file names
  local FILE
  for FILE in "$@"; do
    wc -l "$FILE"
  done
}

ncol() {
  # Count the number of columns in file(s) header
  # $1 $2 = potentially a delimiter, i.e., -d ,
  # (these two arguments are optional and -d must be the first)
  # $@ file names
  local DELIM FILE NCOL
  if [[ $1 == "-d" ]]; then
    DELIM=$2
    shift 2
  else
    DELIM=" "
  fi
  # echo "DELIM is |$DELIM|"
  # echo "args are $@"
  for FILE in "$@"; do
    NCOL=$(head -n 1 "$FILE" | awk -F "$DELIM" '{ print NF }')
    echo "$NCOL $FILE"
    unset NCOL
  done
}
