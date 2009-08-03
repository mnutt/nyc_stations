#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../config/environment'
require 'fileutils'

Station.all.each{|s| s.update_attribute(:commit, nil) }

GIT_DIR = "#{RAILS_ROOT}/git"
FileUtils.mkdir_p(GIT_DIR)
`cd #{GIT_DIR} && git init`
`cd #{GIT_DIR} && touch .gitignore && git add .gitignore && git commit -m "init"`

Line.all.each do |line|
  puts "Creating #{line.name.upcase} Line..."
  `cd #{GIT_DIR} && git symbolic-ref HEAD refs/heads/#{line.name}`
  `cd #{GIT_DIR} && rm .git/index`
  `cd #{GIT_DIR} && git clean -fdx`
  #`cd #{GIT_DIR} && git checkout -b #{line.name}`
  `cd #{GIT_DIR} && touch #{line.name}_line && git add #{line.name}_line`
  `cd #{GIT_DIR} && git commit -m "#{line.name.upcase} Line"`
end

#require 'mojombo-grit'
#include Grit
#Grit.debug
#Grit.use_pure_ruby

#repo = Repo.new(GIT_DIR)

#Line.all.each do |line|
#  repo.checkout(line.name)
#  repo.
#end

Line.all.each do |line|
  puts `cd #{GIT_DIR} && git checkout #{line.name}`
  line.stations.each do |station|
    if(station.commit)
      puts "  merging with #{station.commit}"
      `cd #{GIT_DIR} && git merge #{station.commit} -m "#{station.name}"`
    else
      puts "  adding #{station.name}"
      output = `cd #{GIT_DIR} && echo "#{station.name}" > #{line.name}_line && git add #{line.name}_line && git commit -m "#{station.name}"`
      output.each_line do |out|
        if /\[[a-z0-9] ([a-z0-9]+)\]/ =~ out
          station.update_attribute(:commit, $1)
        end
      end
    end
  end
end
