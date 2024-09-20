
# rmd
#-------------------------------------------------------------------------------

rmd() {
    local NAME MAP YORN REPEAT FORCE USAGE CREATE OPTIONS OPTION
    NAME=rmd
    FORCE=no
    USAGE=yes
    CREATE=no
    usage()
    {
        cat <<EOF
NAME
    $NAME - Remove a directory that might not be empty
        (user is prompted before removal)

SYNOPSIS
    $NAME [OPTION] map1 map2 ...

DESCRIPTION
   Following options can be used:

    -c, --create
      Create back removed directory.

    -f, --force
      Do not ask for confirmation. Use with care!

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
    Gregor GORJANC <gregor.gorjanc at gmail dot com>

EOF
    }

    # --- Options ---

    OPTIONS=("$@")
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

    rmMap() {
        if [ -e "$1" ]; then
            if [ -d "$1" ]; then
                rm -Rf "$1"
                if [ -e "$1" ]; then
                    echo "Directory $1 not removed. Something went wrong! "
                elif [ -n "$2" -a "$2" = "yes" ]; then
                    mkdir "$1"
                    echo "Directory $1 cleaned. "
                else
                    echo "Directory $1 removed. "
                fi
            else
                echo "$1 is not a directory. Skipped! "
            fi
        else
            echo "Directory $1 doesn't exist. "
        fi
    }

    # --- Core ---

    if [ -n "$OPTIONS" ]; then
        echo "Working directory ${PWD}. "
        for MAP in "${OPTIONS[@]}"; do
            if [ "$FORCE" = "no" ]; then
                REPEAT=true
                while ${REPEAT}; do
                    echo
                    echo -e "Are you sure to remove directory $MAP (y/s/N)? s - show contents \c"
                    read YORN
                    REPEAT=false
                    if [ "${YORN}" = "y" ]; then
                        rmMap "$MAP" "$CREATE"
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
                rmMap "$MAP" "$CREATE"
            fi
        done
    else
        if [ "$USAGE" = "yes" ]; then
            usage
        fi
    fi
}

# cld
#-------------------------------------------------------------------------------

cld() {
    local NAME
    NAME=cld
    usage()
    {
        cat <<EOF
NAME
    $NAME - Empty/clear a directory (user is prompted before removal)

SYNOPSIS
    $NAME [OPTION] map1 map2 ...

DESCRIPTION
   Following options can be used:

    -f, --force
      Do not ask for confirmation. Use with care!

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
    Gregor GORJANC <gregor.gorjanc at gmail dot com>

EOF
    }
    rmd "$@" --create
}

# rmtex
#-------------------------------------------------------------------------------

rmtex() {
    # removes defined TeX temporary files in current directory.
    local NAME FILES FILE YORN REPEAT USAGE
    NAME=rmtex
    USAGE="$NAME"
    FILES=("*.log" "*.aux" "*.blg" "*.toc" "*.lot" "*.lof" "*.loa" "*.dvi" "*.idx" "*.bbl" "*.ilg" "*.ind" "*.tex.dep" "*.bm" "*.synctex.gz")

    echo "Working directory ${PWD}"
    REPEAT=true
    while $REPEAT; do
        echo
        echo "--> ${FILES[*]}"
        echo -e "Are you sure to remove TeX temporary files in this directory (y/s/N) s - show files? \c"
        read YORN
        REPEAT=false
        case "$YORN" in
            y)
                setopt nullglob   # Prevent errors if no files match the glob patterns
                for FILE in "${FILES[@]}"; do
                    MATCHED_FILES=(${~FILE}) # Expand the glob pattern and store in an array
                    if [ -n "$MATCHED_FILES" ]; then
                        rm -f -- ${MATCHED_FILES[@]} # Remove matched files, if any
                        echo "TeX temporary files matching $FILE removed."
                    fi
                done
                unsetopt nullglob  # Reset to the default behavior once done
                ;;
            s)
                echo "Listing TeX temporary files:"
                for FILE in "${FILES[@]}"; do
                    find . -maxdepth 1 -name "$FILE"
                done
                REPEAT=true
                ;;
            *)
                echo "TeX temporary files not removed."
                ;;
        esac
    done
}
