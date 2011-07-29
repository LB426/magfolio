#!/bin/sh

convert=`which convert`


start() {
  local fullname="$1"
  local filename=`basename "$1"`
  local fileext="${filename##*.}"
  local ext2lower=`echo "$ext" | tr A-Z a-z`
  if [[ $fullname == *.jpg ]]
  then
    echo $fullname
    $convert -quality 40% "$fullname" "$fullname"
  fi
}
 
scan() {
  local x;
  for e in "$1"/*; do
    x=${e##*\/}
    if [ -d "$e" -a ! -L "$e" ]
    then
      scan "$e"
    else
      start "$e"
    fi
  done
}
 
[ $# -eq 0 ] && dir=`pwd` || dir=$@
 
scan "$dir"