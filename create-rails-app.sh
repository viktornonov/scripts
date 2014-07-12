#!/bin/bash
# create rails application from scratch

#check requirements
command -v rvm >/dev/null 2>&1 || { echo >&2 "I require 'rvm' but it's not installed.  Aborting."; exit 1; }
command -v gem >/dev/null 2>&1 || { echo >&2 "I require 'gem' but it's not installed.  Aborting."; exit 1; }

mkdir $1
cd $1

rvm gemset create $1-gems
rvm gemset use $1-gems
cd .
gem install rails
rails new $1
cd $1

rvm gemset list

echo 'Success.'

