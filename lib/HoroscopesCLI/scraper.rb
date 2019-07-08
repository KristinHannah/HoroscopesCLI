require "nokogiri"
require "open-uri"
require "pry"

class HoroscopesCLI::Scraper 
  
 # def self.getUrl
#    html = Nokogiri::HTML(open("https://www.horoscope.com/us/index.aspx"))
 #   html
#  end 
  
  def scrape_index_page
    html = Nokogiri::HTML(open("https://www.horoscope.com/us/index.aspx"))
    signs_list = []
    html.css("div.grid.grid-6 a").each do |item|
      signs_list << {
        :sign => item.css('h3').text,
        :url => "https://www.horoscope.com" + item.attribute('href').value,
        :sign_dates => item.css('p').text
      }
    end
   signs_list
  end
  
    def self.scrape_info(sign)
  url = sign.url
  html = Nokogiri.HTML(open(url))
  
  sign_atts = {}
  
   sign_atts[:today_date] = html.css("div.grid.grid-right-sidebar div p strong.date").text
   
      horoscopeAllText = html.css("div.grid.grid-right-sidebar div p").text
      allTextArray = horoscopeAllText.split(" - ")
      horoscope_text = allTextArray[1]
      horoscope_split = horoscope_text.split("Confused about")
      horoscope_only = horoscope_split[0]
   sign_atts[:horoscope] = horoscope_only
   
       sign_atts[:link_info] = html.css("div.grid.grid-right-sidebar div.more-btns.more-horoscopes a#src-horo-btn-love").attribute('href').value
   sign_atts[:love_link] = "https://www.horoscope.com" + link_info
   
   sign_atts
   binding.pry
  end
  
    def self.scrape_love_info(sign)
    url = sign.love_link
    html = Nokogiri.HTML(open(url))
   sign_att = {}
   
      loveFullText = html.css("div.grid.grid-right-sidebar p").text
      loveArray1 = loveFullText.split(" - ")
      horo = loveArray1[1]
      horoSplit = horo.split("Meet highly")
   sign_att[:love_scope] = horoSplit[0]
   sign_att
   binding.pry
  end 
end 
