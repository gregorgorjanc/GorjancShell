
# NROW, NCOL, and DIM
#-------------------------------------------------------------------------------
# What: Count the number of rows and columns in a file
# Who: Gregor Gorjanc
# When:
#  * 2014-01 Make them independent
#  * 2012-12 Initial version
#-------------------------------------------------------------------------------

dim()
{
  ## $1 $2 = potentially a delimiter, i.e., -d ,
  ## $@ = file names
  local DELIM FILE NROW NCOL
  if [[ $1 == "-d" ]]; then
    DELIM=$2
    shift 2
  else
    DELIM=" "
  fi
  # echo "DELIM is |$DELIM|"
  # echo "args are $@"
  for FILE in $@; do
    NROW=$(wc -l $FILE | awk '{ print $1}')
    NCOL=$(head -n 1 $FILE | awk -F "$DELIM" '{ print NF }')
    echo "$NROW $NCOL $FILE"
    unset NROW NCOL
  done
}
export -f dim

nrow()
{
  ## $@ = file names
  local FILE
  for FILE in $@; do
    wc -l $FILE
  done
}
export -f nrow

ncol()
{
  ## $1 $2 = potentially a delimiter, i.e., -d ,
  ## $@ = file names
  local DELIM FILE NCOL
  if [[ $1 == "-d" ]]; then
    DELIM=$2
    shift 2
  else
    DELIM=" "
  fi
  # echo "DELIM is |$DELIM|"
  # echo "args are $@"
  for FILE in $@; do
    NCOL=$(head -n 1 $FILE | awk -F "$DELIM" '{ print NF }')
    echo "$NCOL $FILE"
    unset NCOL
  done
}
export -f ncol
