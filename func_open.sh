
# --- Open ---

open() # My-time-stamp: <2013-11 Gregor Gorjanc>
{
  # Open $@ with application chosen on extension and/or file output
  local FILE TMP EXT
  NAME='open'
  USAGE="$NAME file1 [file2 ...]"
  for FILE in $@; do
    echo $FILE

    # --- Figure out what kind of file is this ---

    isText()
    {
       # Is $1 a text (ASCII) file? --> exit code is 0
       local TMP
       TMP=$(file -i $1 | grep -e 'text' -e 'regular file')
       if [ -n "$TMP" ]; then
          return 0
       else
          return 1
       fi
    }

    # Take only basename
    TMP=$(basename $FILE)
    # Strip of the name of the file and lower the extension
    EXT=$(echo $TMP | sed -e "s/^.*\.//" | tr [:upper:] [:lower:])
    if [ ! -n "$EXT" ]; then     # files without extension
      isText $FILE               # text file?
      if [ "$?" == "0" ]; then
        EXT="txt"
      fi
    fi

    # --- Use appropriate application ---

    case $EXT in
      # Some ASCII files
      bash | bat | bib | c | cpp | c++ | f | for | f90 | pl | py | r | rd | sh | sql | tex | txt | eml)
        echo "ASCII file"
        $EDITOR $FILE &
      ;;
      lyx)
        echo "LyX file"
        $LYXAPP $FILE &
      ;;
      pdf)
        echo "PDF file"
        $PDFAPP $FILE &
      ;;
      eps | ps)
        echo "EPS/PS file"
        $PSAPP $FILE &
      ;;
      dvi)
        echo "DVI file"
        evince $FILE &
      ;;
      djvu)
        echo "DJVU file"
        evince $FILE &
      ;;
      chm)
        echo "CHM file"
        xchm $FILE &
      ;;
      # Pictures
      bmp | gif | ico | jpg | jpeg | png)
        echo "Graphics file"
        $FIGAPP $FILE &
      ;;
      # www
      htm | html)
        echo "HTML file"
        firefox $FILE &
      ;;
      # Office
      doc | docx | ods | odp | ppt | pptx | xls | xlsx)
        echo "Office file"
        ooffice $FILE &
      ;;
      # Movies & Music
      flv | mp3 | mpg | wmv)
        echo "Music file"
        totem $FILE &
      ;;
      # Archive files
      bz2 | deb | gz | jar | rar | tar | tar.bz2 | tar.gz | tgz | zip)
        echo "Archive file"
        file-roller $FILE &
      ;;
      # Desperate choice (text file?)
      *)
        isText $FILE
        if [ "$?" == "0" ]; then
          echo "ASCII file"
          $EDITOR $FILE &
        else
          # Give up
          echo "${FILE}: could not find appropriate application"
          file -i $FILE
        fi
      ;;
    esac
  done
}
export -f open
