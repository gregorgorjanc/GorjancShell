# server
#-------------------------------------------------------------------------------

server() {
  # Set server specific aliases and functions
  # $1 = server name abbreviation
  # $2 = server IP address
  # $3 = username
  # $4 = SSH options

  local optSSH="${4//-P/-p}"
  local optSCP="${4//-p/-P}"

  alias "ping${1}=ping ${2}"
  alias "login${1}=ssh ${optSSH} ${3}@${2}"

  eval "
  rsyncFrom${1}() {
    local i
    for i in \"\$@\"; do
      rsync ${3}@${2}:\$i .
    done
  }"
  export -f "rsyncFrom${1}"

  eval "
  pull${1}() {
    local i
    for i in \"\$@\"; do
      scp -r ${optSCP} ${3}@${2}:\$i .
    done
  }"
  export -f "pull${1}"

  eval "
  push${1}() {
    echo \"TODO: how could we add an option to push to a user-defined folder instead of ~/.\"
    scp -r ${optSCP} \"\$@\" ${3}@${2}:~/.
  }"
  export -f "push${1}"

  eval "
  diff${1}() {
    local DIFF=diff
    if [[ \"\$1\" == --diff=* ]]; then
      DIFF=\"\${1#--diff=}\"
      shift
    fi
    local file=\$(basename \"\$1\")
    scp ${optSCP} ${3}@${2}:\"\$1\" \"\${file}_from_${1}\"
    local trg=\"\${2:-\$file}\"

    echo \"Compare \${file}_from_${1} to \${trg} (12=default) or vice versa (21)?\"
    read -r WAY
    if [[ \"\$WAY\" == \"21\" ]]; then
      \"\$DIFF\" \"\$trg\" \"\${file}_from_${1}\"
    else
      \"\$DIFF\" \"\${file}_from_${1}\" \"\$trg\"
    fi

    echo \"\\nRemove the copied file \${file}_from_${1} (Y/n)?\"
    read -r YORN
    if [[ \"\$YORN\" != \"n\" ]]; then
       rm -f \"\${file}_from_${1}\"
    fi
  }"
  export -f "diff${1}"

  eval "
  cwdiff${1}() {
    diff${1} --diff=cwdiff \"\$@\"
  }"
  export -f "cwdiff${1}"

  eval "
  colordiff${1}() {
    diff${1} --diff=colordiff \"\$@\"
  }"
  export -f "colordiff${1}"
}
