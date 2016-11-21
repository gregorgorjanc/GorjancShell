
# INV_WOMBAT2ASREML & INV_ASREML2WOMBAT
#-------------------------------------------------------------------------------
# What: Convert inverse covariance matrix file in sparse matrix format
#       (triplets i j x) between formats for ASReml and WOMBAT
# Who: Gregor Gorjanc
# When:
#  * 2013-12 Initial version
#-------------------------------------------------------------------------------

inv_wombat2asreml()
{
  n=$(wc -l $1 | awk '{ print $1 }')
  let n=$n-1
  tail -n $n $1 | awk '{ print $2" "$1" "$3 }'
}
export -f inv_wombat2asreml

inv_asreml2wombat()
{
  echo "0.0"
  awk '{ print $2" "$1" "$3 }' $1
}
export -f inv_asreml2wombat
