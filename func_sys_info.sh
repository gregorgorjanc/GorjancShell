
# SYS_INFO
#-------------------------------------------------------------------------------
# What: Print system info
# Who: Gregor Gorjanc
# When:
#  * 2013-12 More general to cope with several platforms etc.
#  * 2008-01 Initial version
#-------------------------------------------------------------------------------

sys_info()
{
  echo -e "\n --> OS (uname -a)"
  uname -a
  echo -e "\n --> Architecture (arch)"
  arch
  if [ $(uname) == Linux ]; then
    echo -e "\n --> OS (lsb_release -a)"
    lsb_release -a
    echo -e "\n --> Release (cat /etc/*release*|debian_version)"
    FILES="/etc/*release* /etc/debian_version"
    for FILE in $FILES; do
      if [ -f $FILE ]; then
        echo $FILE
        cat $FILE
      fi
    done
    echo -e "\n --> Processor (grep "Hz" /proc/cpuinfo)"
    grep "Hz" /proc/cpuinfo | grep "model name"
    echo -e " --> #Processors:"
    grep "Hz" /proc/cpuinfo | grep "model name" | wc -l
    echo -e " --> #Processors available to you:"
    nproc
    echo -e "\n --> Memory (free -gt)"
    free -gt
  fi
  if [ $(uname) == Darwin ]; then
    echo -e "\n --> System profile (system_profiler SPHardwareDataType)"
    system_profiler SPHardwareDataType
  fi
  echo -e "\n --> Disk (df -Th)"
  df -h
}
export -f sys_info
