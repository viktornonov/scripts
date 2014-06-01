#!/bin/bash
#script for reading file spliting it by new line

declare -a ARRAY

exec < text_file.txt

let count=0
while read LINE <&10; do
	ARRAY[$count]=$LINE
  ((count++))
done
# restrore stdout
exec 10>&-

echo Number of elements: ${#ARRAY[@]}
echo 'array content:'
echo ${ARRAY[@]}
