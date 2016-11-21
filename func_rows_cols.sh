
# ROWS & COLS
#-------------------------------------------------------------------------------
# What: Print out few rows and cols of a file
# Who: Gregor Gorjanc
# When:
#  * 2013-12 Initial version
#-------------------------------------------------------------------------------

rows()
{
  ## $1 = starting row
  ## $2 = ending row
  ## $3 = file
  nr=$(wc -l $3 | awk '{ print $1 }')
  let d=$2-$1+1
  head -n $2 $3 | tail -n $d
}
export -f rows

cols()
{
  ## $1 = starting column
  ## $2 = ending column
  ## $3 = file
  ## $4 = separator
  if [ -n $4 ]; then
     d=" "
  else
     d=$4
  fi
  cut -d "$d" -f$1-$2 $3
}
export -f rows
