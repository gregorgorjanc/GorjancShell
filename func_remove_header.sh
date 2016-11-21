
# REMOVE_HEADER
#-------------------------------------------------------------------------------
# What: Remove header from a file
# Who: Gregor Gorjanc
# When:
#  * 2013-12 Initial version
#-------------------------------------------------------------------------------

remove_header()
{
  n=$(wc -l $1 | awk '{ print $1 }')
  let n=$n-1
  tail -n $n $1
}
export -f remove_header
