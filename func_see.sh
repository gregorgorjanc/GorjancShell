
# SEE & SEE_COL
#-------------------------------------------------------------------------------
# What: See file contents quickly, i.e., head and tail
# Who: Gregor Gorjanc
# When:
#  * 2013-12 Initial version
#-------------------------------------------------------------------------------

see()
{
  ## $@ = file names
  lines=5
  col_limit=20
  for f in "$@"; do
    nc=$(head -n 1 $f | awk '{ print NF }')
    if [ $nc -gt $col_limit ]; then
      echo -e "\nMore than ${col_limit} columns, using see_col!"
      see_col $f
    else
      nr=$(wc -l $f | awk '{ print $1 }')
      echo "\n$f, nrow=$nr, ncol=$nc"
      head -n $lines $f
      if [ $nr -gt $lines ]; then
        echo "..."
        echo "..."
        echo "..."
        tail -n $lines $f
      fi
    fi
  done
}
export -f see

see_col()
{
  ## $@ = file names
  lines=5
  for f in $@; do
    nc=$(head -n 1 $f | awk '{ print NF }')
    nr=$(wc -l $f | awk '{ print $1 }')
    echo "\n$f, nrow=$nr, ncol=$nc"
    ## TODO: see comments in head_col
    if [ $nc -le 10 ]; then
      scr="{ out=\$1; for (i=2; i<=10; i++) { out=out\" \"\$i }; print out }"
    else
      scr="{ out=\$1; for (i=2; i<=10; i++) { out=out\" \"\$i }; print out\" ... \"\$$nc }"
    fi
    head -n $lines $f | awk "$scr"
    if [ $nr -gt $lines ]; then
      echo "..."
      echo "..."
      echo "..."
      tail -n $lines $f | awk "$scr"
    fi
  done
}
export -f see_col

# HEAD_COL & TAIL_COL
#-------------------------------------------------------------------------------
# What: Show first/last rows and cols of a file, i.e., just first/last few
#       rows and first/last few columns (useful when a file is very big)
# Who: Gregor Gorjanc
# When:
#  * 2013-12 Initial version
#-------------------------------------------------------------------------------

head_col()
{
  ## $@ = file names
  ## TODO: can we make no of cols an option?
  ## TODO: delimiter as an option
  ## TODO: combine {head,tail,see}_col as most code is the same
  local nc
  for f in $@; do
    nc=$(head -n 1 $f | awk '{ print NF }')
    nr=$(wc -l $f | awk '{ print $1 }')
    echo "\n$f, nrow=$nr, ncol=$nc"
    if [ $nc -le 10 ]; then
      scr="{ out=\$1; for (i=2; i<=10; i++) { out=out\" \"\$i }; print out }"
    else
      scr="{ out=\$1; for (i=2; i<=10; i++) { out=out\" \"\$i }; print out\" ... \"\$$nc }"
    fi
    head $f | awk "$scr"
  done
}
export -f head_col

tail_col()
{
  ## $@ = file names
  local nc
  for f in $@; do
    nc=$(head -n 1 $f | awk '{ print NF }')
    nr=$(wc -l $f | awk '{ print $1 }')
    echo "\n$f, nrow=$nr, ncol=$nc"
    ## TODO: see above comments in head_col
    if [ $nc -le 10 ]; then
      scr="{ out=\$1; for (i=2; i<=10; i++) { out=out\" \"\$i }; print out }"
    else
      scr="{ out=\$1; for (i=2; i<=10; i++) { out=out\" \"\$i }; print out\" ... \"\$$nc }"
    fi
    tail $f | awk "$scr"
  done
}
export -f tail_col
