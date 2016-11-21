
# FUNC
#-------------------------------------------------------------------------------

# Function func prints out definitions for functions named by arguments
# '/usr/share/doc/bash-2.05b/functions/func' from RH8.0.

# Usage: func name [name ...]

# Chet Ramey
# chet@ins.CWRU.Edu

func()
{
    local STATUS=0

    if [ $# -eq 0 ] ; then
        echo "usage: func name [name...]" 1>&2
        return 1
    fi

    for F ; do
       if [ "$(builtin type -type $F)" != "function" ] ; then
           echo "func: $F: not a function" 1>&2
           STATUS=1        # one failed
           continue
       fi
       builtin type $F | sed 1d
    done
    return $STATUS
}
export -f func
