#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../config/environment'
require 'fileutils'

GIT_DIR = "#{RAILS_ROOT}/git"
FileUtils.mkdir_p(GIT_DIR)
`cd #{GIT_DIR} && git init`
`cd #{GIT_DIR} && touch .gitignore && git add .gitignore && git commit -m "init"`

Line.all.each do |line|
  puts "Creating #{line.name.upcase} Line..."
  #`cd #{GIT_DIR} && git symbolic-ref HEAD refs/heads/#{line.name}`
  #`cd #{GIT_DIR} && rm .git/index`
  #`cd #{GIT_DIR} && git clean -fdx`
  `cd #{GIT_DIR} && git checkout -b #{line.name}`
  `cd #{GIT_DIR} && touch #{line.name}_line && git add #{line.name}_line`
  `cd #{GIT_DIR} && git commit -m "#{line.name.upcase} Line"`
end

Line.all.each do |line|
  puts `cd #{GIT_DIR} && git checkout #{line.name}`
  line.stations.each do |station|
    puts "  adding #{station.name}"
    `cd #{GIT_DIR} && echo "#{station.name}" > #{line.name}_line && git add #{line.name}_line && git commit -m "#{station.name}"`
  end
end
