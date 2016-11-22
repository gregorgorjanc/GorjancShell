
# X2Y
#------------------------------------------------------------------------------

lyx2ps()
{
  local STRING
  for STRING in $*; do
    lyx $STRING -e ps
  done
}
export -f lyx2ps

lyx2pdf()
{
  local STRING
  for STRING in $*; do
    lyx $STRING -e pdf
  done
}
export -f lyx2pdf

lyx2tex()
{
  local STRING
  for STRING in $*; do
    lyx $STRING -e latex
  done
}
export -f lyx2tex

tex2pdf()
{
  local STRING
  for STRING in $*; do
    texi2dvi --pdf --quiet --clean $STRING
  done
}
export -f tex2pdf

tex2ps()
{
  local STRING
  for STRING in $*; do
    texi2dvi --quiet --clean $STRING
    STRING=$(echo $STRING | sed 's/.tex$/.dvi/')
    dvips $STRING
    rm -f $STRING
  done
}
export -f tex2ps

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
