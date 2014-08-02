#!/bin/bash
# basic script for uploading assets to AWS using s3funnel
# script traverses LOCAL_DIR recursively

readonly LOCAL_DIR=bash-scripts
readonly BUCKET="bucket_name"
readonly ACCESS_KEY="access key"
readonly SECRET_KEY="secret key"
readonly NUMBER_THREADS=8
directories=$(find $LOCAL_DIR -type d)
for directory in $directories; do
  echo "uploading $directory"
  s3funnel $BUCKET PUT -a $ACCESS_KEY -s $SECRET_KEY -t $NUMBER_THREADS --put-full-path `echo $directory/*`
done
