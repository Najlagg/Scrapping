require 'nokogiri'
require 'open-uri'
   


def get_townhall_url

    array_url=[]

    page_annuaire = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

    url = page_annuaire.xpath('//a[@class="lientxt"]/@href').each do |townhall_url| 
        array_url << townhall_url.text 
    end
    better_url = array_url.map{|s| "http://annuaire-des-mairies.com#{s[1..-1]}"}
    return better_url
end


def get_townhall_email(array_url)

    
    page_coordonnees = Nokogiri::HTML(URI.open(array_url))

    email = page_coordonnees.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text

    return email
end


def perform
    tableau = []
    better_url = get_townhall_url
    better_url.each do |lien| 
        email = get_townhall_email(lien)
        tableau << email
    end
    puts tableau
end

perform