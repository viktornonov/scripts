#!/bin/bash
# create rails application from scratch

#check requirements
command -v rvm >/dev/null 2>&1 || { echo >&2 "I require 'rvm' but it's not installed.  Aborting."; exit 1; }
command -v gem >/dev/null 2>&1 || { echo >&2 "I require 'gem' but it's not installed.  Aborting."; exit 1; }

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

echo Marking dir $1
mkdir $1
cd MarkTwo

echo Creating gemset $1-gems
rvm gemset create $1-gems
rvm gemset use $1-gems

cd .
echo Installing rails
gem install rails

echo Creating new rails application
rails new $1
echo Creating .ruby-version and .ruby-gemset files
echo "ruby-2.1.1" > $1/.ruby-version
echo "$1-gems" > $1/.ruby-gemset

rvm gemset list

echo 'Success.'

