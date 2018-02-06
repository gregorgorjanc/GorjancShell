
# SERVER
#-------------------------------------------------------------------------------
# What: Set server specific aliases and functions
# Who: Gregor Gorjanc
#-------------------------------------------------------------------------------

server()
{
  # $1 = server name abbreviation
  # $2 = server IP address
  # $3 = username
  # $4 = SSH options

  optSSH=$(echo ${4} | sed -e "s/-P/-p/")
  optSCP=$(echo ${4} | sed -e "s/-p/-P/")

  eval "alias ping${1}=\"ping ${2}\""
  eval "alias login${1}=\"ssh ${optSSH} ${3}@${2}\""

  eval "rsyncFrom${1}()
  {
    local i
    for i in \$@; do
      rsync ${3}@${2}:\$i .
    done
  }; export -f rsyncFrom${1}"

  eval "pull${1}()
  {
    local i
    for i in \$@; do
      scp -r ${optSCP} ${3}@${2}:\$i .
    done
  }; export -f pull${1}"

  eval "push${1}()
  {
    echo "TODO: how to add an option to push to a user defined folder instead of ~/."
    scp -r ${optSCP} \$@ ${3}@${2}:~/.
  }; export -f push${1}"

  eval "diff${1}()
  {
    DIFF=diff
    case \${1} in
      --diff=* )
        DIFF=\$(echo \${1} | sed -e \"s/--diff=//\")
        shift
        ;;
    esac
    file=\$(basename \${1})
    scp ${optSCP} ${3}@${2}:\${1} \${file}_from_${1}
    if [ -z \"\${2}\" ]; then
      trg=\${file}
    else
      trg=\${2}
    fi
    echo \"Compare \${file}_from_${1} to \${trg} (12=default) or vice versa (21)?\"
    read WAY
    if [ \"\${WAY}\" == \"21\" ]; then
      \${DIFF} \${trg} \${file}_from_${1}
    else
      \${DIFF} \${file}_from_${1} \${trg}
    fi
    echo \"\nRemove the copied file \${file}_from_${1} (Y/n)?\"
    read YORN
    if [ \"\${YORN}\" != \"n\" ]; then
       rm -f \${file}_from_${1}
    fi
  }; export -f diff${1}"

  eval "cwdiff${1}()
  {
    diff${1} --diff=cwdiff \${@}
  }; export -f cwdiff${1}"

  eval "colordiff${1}()
  {
    diff${1} --diff=colordiff \${@}
  }; export -f colordiff${1}"
}
export -f server
