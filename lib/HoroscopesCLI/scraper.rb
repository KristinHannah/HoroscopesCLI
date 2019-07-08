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
      if horoscope_text.include?("Confused about")
        horoscope_split = horoscope_text.split("Confused about")
        horoscope_only = horoscope_split[0]
      elsif horoscope_text.include?("Discover what's")
        horoscope_split = horoscope_text.split("Discover what's")
        horoscope_only = horoscope_split[0]
      elsif horoscope_text.include?("Dig deep")
        horoscope_split = horoscope_text.split("Dig deep")
        horoscope_only = horoscope_split[0]
      elsif horoscope_text.include?("Revive your love")
        horoscope_split = horoscope_text.split("Revive your love")
        horoscope_only = horoscope_split[0]
      elsif horoscope_text.include?("Get Instant Answers")
        horoscope_split = horoscope_text.split("Get Instant Answer")
        horoscope_only = horoscope_split[0]
      else 
        horoscope_only = horoscope_text
      end
   sign_atts[:horoscope] = horoscope_only
   
       link_info = html.css("div.grid.grid-right-sidebar div.more-btns.more-horoscopes a#src-horo-btn-love").attribute('href').value
   sign_atts[:love_link] = "https://www.horoscope.com" + link_info
   
   sign_atts
  # binding.pry
  end
  
  def self.scrape_love_info(sign)
    url = sign.love_link
    html = Nokogiri.HTML(open(url))
   sign_att = {}
   
      loveFullText = html.css("div.grid.grid-right-sidebar p").text
      loveArray1 = loveFullText.split(" - ")
      horo = loveArray1[1]
      if horo.include?("Find your 2019")
        horoSplit = horo.split("Find your 2019")
        love_horo = horoSplit[0]
      elsif horo.include?("If you're looking for")
       horoSplit = horo.split("If you're looking for")
       love_horo = horoSplit[0]
      elsif horo.include?("Did you know:")
       horoSplit = horo.split("Did you know:")
       love_horo = horoSplit[0]
      elsif horo.include?("If you are looking for")
       horoSplit = horo.split("If you are looking for")
       love_horo = horoSplit[0]
      elsif horo.include?("Make 2019 the year")
       horoSplit = horo.split("Make 2019 the year")
       love_horo = horoSplit[0]
      elsif horo.include?("Meet highly")
       horoSplit = horo.split("Meet highly")
       love_horo = horoSplit[0]
      elsif horo.include?("Every 14 minutes")
       horoSplit = horo.split("Every 14 minutes")
       love_horo = horoSplit[0]
      elsif horo.include?("2019 is all about")
       horoSplit = horo.split("2019 is all about")
       love_horo = horoSplit[0]
      elsif horo.include?("Join eharmony")
       horoSplit = horo.split("Join eharmony")
       love_horo = horoSplit[0]
      elsif horo.include?("Join now for lasting and fulfilling")
       horoSplit = horo.split("Join now for lasting and fulfilling")
       love_horo = horoSplit[0]
     else 
       love_horo = horo 
     end 
   sign_att[:love_scope] = love_horo
   sign_att
   #binding.pry
  end 
end 
