require "nokogiri"
require "open-uri"
require "pry"

class HoroscopesCLI::Scraper 
  
  def self.getUrl
    html = Nokogiri::HTML(open("https://www.horoscope.com/us/index.aspx"))
    html
  end 
  
  def self.scrape_index_page
    signs_list = []
   self.getUrl.css("div.grid.grid-6 a").each do |item|
      signs_list << {
        :sign => item.css('h3').text,
        :url => "https://www.horoscope.com" + item.attribute('href').value,
        :sign_dates => item.css('p').text
      }
    end
   signs_list
  end
  
  
end 
