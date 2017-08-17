#!/usr/bin/env ruby

def run(branch)
  puts "Comparing to #{branch}"

  added_migration_files = `git diff #{branch} --name-status db/migrate`
                          .split("\n")
                          .map { |git_row| git_row.gsub(/[AM]\t/,'') }

  if added_migration_files.empty?
    puts "No migrations to revert before switch from #{`git rev-parse --abbrev-ref HEAD`.gsub(/\n/,'')} to #{branch}"
  end

  timestamp_filename = added_migration_files.reverse.inject({}) do |h, file|
    timestamp = file.match(/\/(\d+)_/)[1]
    h[timestamp] = file
    h
  end

  timestamp_filename.each_pair do |timestamp, filename|
    puts "Reverting #{filename}"
    command = "bundle exec rake db:migrate:down VERSION=#{timestamp}"
    puts command
    status = `#{command}`
    puts "Status - #{status}"
  end
end

def usage
  puts "Usage:"
  puts "#{__FILE__} branch_name"
  exit
end

def die_if_there_are_dirty_files
  changed_files = `git ls-files -m`
  unless changed_files.empty?
    puts 'There are changed files in the directory'
    exit
  end
end

usage if ARGV.count < 1
die_if_there_are_dirty_files
run(ARGV[0])
