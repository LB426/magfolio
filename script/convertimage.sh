#!/bin/sh

DIR="/home/magfolio/magfolio/current/public/assets/pictures"
convert=`which convert`
NAMES=`find $DIR -name original -prune -o -name '*.jpg' -print`

echo $DIR
echo $convert

for f in $NAMES
do
  $convert -quality 40% $f $f
  size=`ls -lah $f | awk '{print $5}'`
  echo $size $f
done