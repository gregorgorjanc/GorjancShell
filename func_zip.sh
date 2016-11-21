
tarx()
{
  tar -xzvvf $1
}
export -f tarx

tarc()
{
  TMP=$(echo $1 | sed -e "s/\/$//")
  tar -czvvf ${TMP}.tgz $TMP
}
export -f tarc

tarcj()
{
  TMP=$(echo $1 | sed -e "s/\/$//")
  tar -cjvvf ${TMP}.tbz2 $TMP
}
export -f tarcj

zipx()
{
  unzip $1
}
export -f zipx

zipc()
{
  TMP=$(echo $1 | sed -e "s/\/$//")
  zip -r9v ${TMP}.zip $TMP
}
export -f zipc
