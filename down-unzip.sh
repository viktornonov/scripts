#!/bin/bash
#reads file, downloads files based on the content and unzip them
readonly URL="website url"
echo enter file name
read fname

mkdir sticker

while read line
do
  url="$URL$line"
  echo $url
  responseCode=$(curl -sL -w "%{http_code}" $url -o /dev/null)
  if [ "$responseCode" = "200" ]; then
    wget -O ./sticker/$line.zip $url
    unzip ./sticker/$line.zip ./sticker
  else
    err.txt < $line
  fi
done < $fname
