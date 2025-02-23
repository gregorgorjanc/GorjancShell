
# see & see_col
#-------------------------------------------------------------------------------

see() {
  # See file contents quickly, i.e., head and tail
  # $@ = file names
  local lines=5
  local col_limit=20
  for f in "$@"; do
    local nc=$(head -n 1 "$f" | awk '{ print NF }')
    if (( nc > col_limit )); then
      echo -e "\nMore than ${col_limit} columns, using see_col!"
      see_col "$f"
    else
      local nr=$(wc -l | awk '{ print $1 }')
      echo "\n$f, nrow=$nr, ncol=$nc"
      head -n $lines "$f"
      if (( nr > lines )); then
        echo "..."
        echo "..."
        echo "..."
        tail -n $lines "$f"
      fi
    fi
  done
}

see_col() {
  # See file contents quickly, i.e., head and tail (only a few columns)
  # $@ = file names
  local lines=5
  for f in "$@"; do
    local nc=$(head -n 1 "$f" | awk '{ print NF }')
    local nr=$(wc -l | awk '{ print $1 }')
    echo "\n$f, nrow=$nr, ncol=$nc"

    # TODO: see comments in head_col
    local scr
    if (( nc <= 10 )); then
      scr='{ out=$1; for (i=2; i<=10; i++) { out=out" "$i }; print out }'
    else
      scr='{ out=$1; for (i=2; i<=10; i++) { out=out" "$i }; print out" ... "$nc }'
    fi

    head -n $lines "$f" | awk "$scr"
    if (( nr > lines )); then
      echo "..."
      echo "..."
      echo "..."
      tail -n $lines "$f" | awk "$scr"
    fi
  done
}

# head_col & tail_col
#-------------------------------------------------------------------------------

head_col() {
  # Show first rows and cols of a file, i.e., just first few
  # rows and first few columns (useful when a file is very big)
  # $@ = file names
  # TODO: can we make no of cols an option?
  # TODO: delimiter as an option
  # TODO: combine {head,tail,see}_col as most code is the same
  for f in "$@"; do
    local nc=$(head -n 1 "$f" | awk '{ print NF }')
    local nr=$(wc -l | awk '{ print $1 }')
    echo "\n$f, nrow=$nr, ncol=$nc"

    local scr
    if (( nc <= 10 )); then
      scr='{ out=$1; for (i=2; i<=10; i++) { out=out" "$i }; print out }'
    else
      scr='{ out=$1; for (i=2; i<=10; i++) { out=out" "$i }; print out" ... "$nc }'
    fi

    head "$f" | awk "$scr"
  done
}

tail_col() {
  # Show last rows and cols of a file, i.e., just last few
  # rows and last few columns (useful when a file is very big)
  # $@ = file names
  for f in "$@"; do
    local nc=$(head -n 1 "$f" | awk '{ print NF }')
    local nr=$(wc -l | awk '{ print $1 }')
    echo "\n$f, nrow=$nr, ncol=$nc"

    ## TODO: see above comments in head_col
    local scr
    if (( nc <= 10 )); then
      scr='{ out=$1; for (i=2; i<=10; i++) { out=out" "$i }; print out }'
    else
      scr='{ out=$1; for (i=2; i<=10; i++) { out=out" "$i }; print out" ... "$nc }'
    fi

    tail "$f" | awk "$scr"
  done
}