require 'net/http'
require 'uri'
require 'rexml/document'

URL = 'https://www.cbr.ru/scripts/XML_daily.asp'.freeze

response = Net::HTTP.get_response(URI.parse(URL))
doc = REXML::Document.new(response.body)

usd_cource = []

usd_currency = doc.each_element('//Valute[@ID="R01235"]') do |currency_tag|
  usd_cource << currency_tag.get_text('Value')
end

cource = usd_cource.join.to_f

puts "How much dollars do you have?"
usd_balance = gets.chomp.to_f

puts "How much rubles do you have?"
rubl_balance = gets.chomp.to_f


rubl_difference = ((rubl_balance - usd_balance * cource) / 2).round(2)
usd_difference = ((usd_balance - rubl_balance / cource) / 2).round(2)

if rubl_difference >= 0.01
  puts "You need to sell #{rubl_diference} rubles"
elsif usd_difference >= 0.01
  puts "You need to sell #{usd_difference} dollars"
else
 puts "You dont need to sell anny money"
end 
