
# FIND*
#-------------------------------------------------------------------------------

# Function findf finds file or files, maps and links, which should be given
# as first paramter. findd finds maps, findl finds symbolic links

# -path and * in string add possibilty to find files like .bashrc

# $* - files, maps, links or strings

# Usage: findf bash [ diary ... ]

# My-time-stamp: <2016-03-08 ggorjanc>

findf()
{
    local STRING NAME HITS TMP TMP2
    NAME='findf'
    USAGE="$NAME file1 [file2 ...]"
    if [ -n "$1" ]; then
        for STRING in $*; do
            eval find . -type f -path \"*${STRING}*\"
            # HITS=$(eval find . -path \"*${STRING}*\")
            # for i in $HITS; do
            #     TMP=$(basename $i)
            #     TMP2=$(echo $TMP | grep $STRING)
            #     if [ -n "$TMP2" ]; then
            #         echo $i
            #     fi
            # done
        done
    else
        echo "Missing argument!"
        echo "Usage: $USAGE"
    fi
}
export -f findf

findd()
{
    local STRING NAME
    NAME='findd'
    USAGE="$NAME map1 [map2 ...]"
    if [ -n "$1" ]; then
        for STRING in $*; do
            eval find . -type d -path \"*${STRING}*\"
        done
    else
        echo "Missing argument!"
        echo "Usage: $USAGE"
    fi
}
export -f findd

findl()
{
    local STRING NAME
    NAME='findl'
    USAGE="$NAME link1 [link2 ...]"
    if [ -n "$1" ]; then
        for STRING in $*; do
            eval find . -type l -path \"*${STRING}*\"
        done
    else
        echo "Missing argument!"
        echo "Usage: $USAGE"
    fi
}
export -f findl
