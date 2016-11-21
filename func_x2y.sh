
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
