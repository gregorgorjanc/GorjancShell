
# Sun Grid Engine (SGE) functions
#-------------------------------------------------------------------------------

# QSTATJ & QSTATL & QSTATALL & QSTATALLL
#-------------------------------------------------------------------------------
# What: qstatj - job names
#       qstatl - qstat | less
#       qstatall - qstat of all users
#       qstatalll - qstat of all users | less
# Who: Gregor Gorjanc
# When:
#  * 2014-05 Initial version
#-------------------------------------------------------------------------------

qstatj()
{
  for j in $(qstat | awk 'NR>1 { print $1 }'); do
    echo $j $(qstat -j $j | grep job_name)
  done
}
export -f qstatj

qstatl()
{
  qstat | less
}
export -f qstatl

qstatall()
{
  qstat -u "*"
}
export -f qstatall

qstatalll()
{
  qstat -u "*" | less
}
export -f qstatalll

# QSTATR
#-------------------------------------------------------------------------------
# What: qstat with refresh
# Who: Kenton D'Mellow
# When:
#  * 2014-04 Initial version
#-------------------------------------------------------------------------------

qstatr()
{
  clear
  TMPFILE=`mktemp -t 2>&1`
  rm -f $TMPFILE
  mkfifo $TMPFILE
  ( cat $TMPFILE & )
  while ( `qstat $1 -u $USER|grep . > $TMPFILE` ); do
    ( cat $TMPFILE & )
    sleep 10
    clear
  done
  rm -f $TMPFILE
}
export -f qstatr

# QDELALL
#-------------------------------------------------------------------------------
# What: qdel all the jobs in a queue
# Who: Gregor Gorjanc
# When:
#  * 2014-05 Initial version
#-------------------------------------------------------------------------------

qdelall()
{
  echo "Are you sure (y/N)? This will kill all the jobs in a queue!!!"
  read YORN
  if [ "$YORN" == "Y" -o "$YORN" == "y" ]; then
    qdel $(qstat | awk 'NR>2 { print $1 }')
  fi
}
export -f qdelall
