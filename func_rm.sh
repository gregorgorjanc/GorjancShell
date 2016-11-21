
# RMD
#-------------------------------------------------------------------------------

# My-time-stamp: <2007-04-14 00:22:14 ggorjan>

rmd()
{
    local NAME MAP YORN REPEAT FORCE USAGE OPTIONS OPTION
    NAME=rmd
    FORCE=no
    USAGE=yes
    CREATE=no
    usage()
    {
        cat <<EOF
NAME
    $NAME - Remove whole directory that might not be empty. User is
          prompted before removal

SYNOPSIS
    $NAME [OPTION] map1 map2 ...

DESCRIPTION
   Following options can be used:

    -c, --create
      Create back removed directory

    -f, --force
      Do not ask. Use with care!

    -h, --help
      Print this output.

EXAMPLE
    Remove directory test
    $NAME test

    Remove directory test and test2
    $NAME test test2

    Remove directory test without asking first
    $NAME -f test

AUTHOR
    Gregor GORJANC <gregor.gorjanc at bfro.uni-lj.si>

EOF
    }

    # --- Options ---

    FORCE=no

    OPTIONS=$@
    for OPTION in "$@"; do
        case "$OPTION" in
            -c | --create )
                OPTIONS=$(echo $OPTIONS | sed -e "s|$OPTION||")
                CREATE=yes
                ;;
            -f | --force )
                OPTIONS=$(echo $OPTIONS | sed -e "s|$OPTION||")
                FORCE=yes
                ;;
            -h | --help )
                OPTIONS=$(echo $OPTIONS | sed -e "s|$OPTION||")
                USAGE=no
                usage
                ;;
            * ) # no options, just run
                ;;
        esac
    done

    # --- Funcs ---

    rmMap()
    {
        if [ -e "$1" ]; then
            rm -Rf "$1"
            if [ -e "$1" ]; then
                echo "Directory $1 not removed. Something went wrong!"
            elif [ -n "$2" -a "$2" = "yes" ]; then
                mkdir "$1"
                echo "Directory $1 cleaned. "
            else
                echo "Directory $1 removed. "
            fi
        else
            echo "Directory $1 doesn't exist. "
        fi
    }

    # --- Core ---

    if [ -n "$OPTIONS" ]; then
        echo "Working directory ${PWD}. "
        for MAP in $OPTIONS; do
            if [ "$FORCE" = "no" ]; then
                REPEAT=true
                while ${REPEAT}; do
                    echo
                    echo -e "Are you sure to remove directory $MAP (y/s/N)? s - show contents \c"
                    read YORN
                    REPEAT=false
                    if [ "${YORN}" = "y" ]; then
                        rmMap $MAP $CREATE
                    elif [ "${YORN}" = "s" ]; then
                        if [ -e "$MAP" ]; then
                            ls -lFa "$MAP"
                            REPEAT=true
                        else
                            echo "Directory $MAP doesn't exist. "
                        fi
                    else
                        echo "Directory $MAP not removed. "
                    fi
                done
            else
                rmMap $MAP $CREATE
            fi
        done
    else
        if [ "$USAGE" = "yes" ]; then
            usage
        fi
    fi
}
export -f rmd

# CLD
#-------------------------------------------------------------------------------

# My-time-stamp: <2007-04-14 00:35:33 ggorjan>

cld()
{
    local NAME
    NAME=cld
    usage()
    {
        cat <<EOF
NAME
    $NAME - Empty whole directory. User is prompted before removal

SYNOPSIS
    $NAME [OPTION] map1 map2 ...

DESCRIPTION
   Following options can be used:

    -f, --force
      Do not ask. Use with care!

    -h, --help
      Print this output.

EXAMPLE
    Empty directory test
    $NAME test

    Empty directory test and test2
    $NAME test test2

    Empty directory test without asking first
    $NAME -f test

AUTHOR
    Gregor GORJANC <gregor.gorjanc at bfro.uni-lj.si>

EOF
    }
    rmd $@ --create
}
export -f cld

# RMTEX
#-------------------------------------------------------------------------------

# rmtex function removes defined TeX temporary files in current directory.

# Usage: rmtex

# My-time-stamp: <2003-08-01 08:10:12 ggorjan>

rmtex()
{
    local NAME FILES FILE YORN REPEAT USAGE
    NAME=rmtex
    USAGE="$NAME"
    FILES="*.log *.aux *.blg *.toc *.lot *.lof *.loa *.dvi *.idx *.bbl
           *.ilg *.ind *.tex.dep *.bm"

    echo "Working directory ${PWD}. "
    REPEAT=true
    while ${REPEAT}; do
        echo
        echo "--> $FILES"
        echo -e "Are you sure to remove TeX temporary files in this map (y/s/N) s - show files?  \c"
        read YORN
        REPEAT=false
        if [ "${YORN}" = "y" ]; then
            if [ -n "$FILES" ]; then
                rm -f $FILES
                echo "TeX temporary files removed. "
            else
                echo "There are no temporary TeX files in this map!"
            fi
        elif [ "${YORN}" = "s" ]; then
            for FILE in $FILES; do
                find -maxdepth 1 -name "$FILE"
            done
            REPEAT=true
        else
            echo "TeX temporary files not removed.  "
        fi
    done
}
export -f rmtex

# RMLYX
#-------------------------------------------------------------------------------

# rmlyx function removes defined LyX temporary files in current directory

# Usage: rmlyx

# My-time-stamp: <2003-08-01 08:10:12 ggorjan>

rmlyx()
{
    local NAME FILES FILE YORN REPEAT USAGE FILES_TEX TMP_TEX FILE_TEX FILE FILE_TEX1
    NAME='rmlyx'
    USAGE="$NAME [map1 map2 ...]"
    FILES="*.log *.aux *.blg *.toc *.lot *.lof *.loa *.dvi *.idx *.bbl *.ilg *.ind *.tex.dep"
    SRCS="tex ps pdf"

    findsrclyx()
    {
        # Removing tex or PS files, but only if lyx exists
        TMP_SRC=""
        FILE_SRC=""
        FILE_SRC1=""
        TMP_SRC=$(find -maxdepth 1 -name "*.$1")
        for FILE_SRC in $TMP_SRC; do
            FILE=$(echo $FILE_SRC | sed -e "s/.$1//")
            if [ -e "${FILE}.lyx" ]; then
                FILE_SRC1="$FILE_SRC1 ${FILE}.${1}"
            fi
        done
    }

    echo "Working directory ${PWD}. "
    REPEAT=true
    while ${REPEAT}; do
        echo
        echo "--> $FILES $FILES_TEX"
        echo "Are you sure to remove LyX temporary files in this map (y/s/a/N)?"
        echo "  s - show files "
        echo "  a - remove all LyX temporary files "
        read YORN
        REPEAT=false
        if [ "$YORN" = "a" ]; then
              YORNALL="y"
        fi
        if [ "${YORN}" = "y" -o "$YORN" = "a" ]; then
            rm -f $FILES
            EXIT="$?"
            if [ "$EXIT" -gt "0" ]; then
                echo "There are no temporary LyX files in this map or something went wrong!"
            else
                echo "LyX temporary files removed. "
            fi
            for SRC in $SRCS; do
                findsrclyx $SRC
                if [ -n "$FILE_SRC1" ]; then
                    if [ "$YORNALL" = "y" ]; then
                        rm -f $FILE_SRC1
                        echo "$SRC files with LyX originals removed."
                    else
                        echo -e "Are you sure to remove $SRC files with LyX originals in this map (y/N)? \c"
                        read YORN
                        if [ "$YORN" = "y" ]; then
                            rm -f $FILE_SRC1
                            echo "$SRC files with LyX originals removed."
                        else
                            echo "$SRC files with LyX originals not removed."
                        fi
                    fi
                else
                    echo "There are no $SRC sources with LyX originals in this map!"
                fi
            done
        elif [ "${YORN}" = "s" ]; then
            for FILE in $FILES; do
                find -maxdepth 1 -name $FILE
            done
            for SRC in $SRCS; do
                findsrclyx $SRC
                echo
                echo "$SRC files with LyX originals."
                echo "$FILE_SRC1"
            done
            REPEAT=true
        else
            echo "LyX temporary files not removed.  "
        fi
    done
}
export -f rmlyx
