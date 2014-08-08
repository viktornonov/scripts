#!/bin/bash
# script used to download images, names of which are written in a text file

readonly BIG_IMAGES_URL="http://app.plastoria.com/files/products/300DPI"
readonly SMALL_IMAGES_URL="http://app.plastoria.com/files/products/72DPI"

echo Enter file name
read fname

mkdir 300DPI

while read line
do
  url="$BIG_IMAGES_URL/$line.jpg"
  echo $url
  responseCode=$(curl -sL -w "%{http_code}" $url -o /dev/null)
  if [ "$responseCode" = "200" ]; then
    wget $url -P ./300DPI
  else
    errors.txt < $line
  fi
done < $fname

mkdir 72DPI

while read line
do
  url="$SMALL_IMAGES_URL/$line.jpg"
  echo $url
  responseCode=$(curl -sL -w "%{http_code}" $url -o /dev/null)
  if [ "$responseCode" = "200" ]; then
    wget $url -P ./72DPI
  else
    errors.txt < $line
  fi
done < $fname
