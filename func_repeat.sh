
# REPEAT
#-------------------------------------------------------------------------------

# Function repeat '/usr/share/doc/bash-2.05b/functions/repeat3' from RH8.0.

# From psamuels@jake.niar.twsu.edu (Peter Samuelson)
# posted to usenet, Message-ID: <6rtp8j$2a0$1@jake.niar.twsu.edu>

# Usage: repeat 10 echo foo

repeat()
{
    local I MAX;     # note that you can use \$i in the command string
    MAX=$1; shift;

    I=1; while ((I <= MAX)); do
        eval "$@"; ((I = I + 1));
    done;
}
export -f repeat
