require 'nokogiri'
require 'open-uri'
   
page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all"))   


crypto_name = page.xpath("//tr/td[3]").map do |name|
    name.text
end.take(20)

crypto_price = page.xpath("//tr/td[5]").map do |price|
    price.text
end.take(20)



result = crypto_name.zip(crypto_price) 

result.map{|name,price|{"#{name}"=>price}}
puts result.inspect