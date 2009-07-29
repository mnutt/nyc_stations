require 'rubygems'
require 'hpricot'
require 'open-uri'

open(ARGV[0]) do |f|
  @content = f.read
end

doc = Hpricot(@content)

puts doc.at('table img').attributes['alt']

table = doc.search('table')[2]

table.search('tr').each do |station|
  next if station.attributes['height'].to_i < 25
  bold_name = station.at('td span.emphasized')
  name = bold_name.parent.inner_text.gsub(/\s+/, ' ').strip
  puts name

  transfer_imgs = station.search('td')[3].search('img')
  transfer_imgs.each do |img|
    file = File.basename(img.attributes['src'])
    line = file.split('_')[0]
    always = file.split('_')[1] == "16.gif"
    puts line + ", " + always.to_s
  end

  buses = station.search('td')[4].inner_text.strip
  puts buses
  # puts station.search('td')[1].inner_html
end
