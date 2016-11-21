
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
  ## $@ = file names
  local NAME FILE NROW NCOL
  NAME=dim
  for FILE in $@; do
    NROW=$(wc -l $FILE | awk '{ print $1}')
    NCOL=$(head -n 1 $FILE | awk '{ print NF }')
    echo "$NROW $NCOL $FILE"
    unset NROW NCOL
  done
}
export -f dim

nrow()
{
  ## $@ = file names
  local NAME FILE
  NAME=nrow
  for FILE in $@; do
    wc -l $FILE
  done
}
export -f nrow

ncol()
{
  ## $@ = file names
  local NAME FILE TMP
  NAME=ncol
  for FILE in $@; do
    TMP=$(head -n 1 $FILE | awk '{ print NF }')
    echo "$TMP $FILE"
    unset TMP
  done
}
export -f ncol
