#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../config/environment'
require 'hpricot'
require 'open-uri'

LINES = %w(one two three four five six seven a b c d e f g j l n q r v w z)

LINES.each do |page|
  url = "http://www.mta.info/nyct/service/#{(page + "line")[0..7]}.htm"

  open(url) do |f|
    @content = f.read
  end
  
  doc = Hpricot(@content)
  
  line = Line.find_or_create_by_name(doc.at('table img').attributes['alt'].split(' ').first.downcase)
  puts "Parsing line " + line.name
  
  table = doc.search('table')[2]
  
  position = 0
  
  table.search('tr').each do |station|
    next if station.attributes['height'].to_i < 25
    station_el = station.at('td span.emphasized').parent rescue station.search('td')[2].at('font')
    name = station_el.inner_text.gsub(/\s+/, ' ').gsub(/\s*\/\s*/, ' / ').strip
    stat = Station.find_or_create_by_name(name)
    Stop.create(:station => stat, :line => line, :position => position, :always => true, :name => stat.name)
    position += 1

    transfer_imgs = station.search('td')[3].search('img')
    transfer_imgs.each do |img|
      file = File.basename(img.attributes['src'])
      line_str = file.split('_')[0]
      always = file.split('_')[1] == "16.gif"
      transfer_line = Line.find_or_create_by_name(line_str.downcase)
      Stop.create(:station => stat, :line => transfer_line, :always => always, :name => stat.name)
    end
    
    buses = station.search('td')[4].inner_text.strip rescue nil
    #puts buses
    # puts station.search('td')[1].inner_html
  end
  puts "#{line.name} train had #{position} stops"
end
