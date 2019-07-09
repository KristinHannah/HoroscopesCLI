
class HoroscopesCLI::CLI 
  
  def call
    makeSigns
    add_attributes
  #  display_signs
    welcomeUser
    askSign
    currentSign
    daily 
    loveScope
   bye
  end 
  
  def makeSigns 
    signs_array = HoroscopesCLI::Scraper.new.scrape_index_page
    HoroscopesCLI::ZodiacSign.create_from_collection(signs_array)
  end 
  
  def add_attributes 
    HoroscopesCLI::ZodiacSign.all.each do |sign|
     attributes = HoroscopesCLI::Scraper.scrape_info(sign)
     sign.add_attributes(attributes)
     love_atts = HoroscopesCLI::Scraper.scrape_love_info(sign)
     sign.add_attributes(love_atts)
  end
  end 
  
   def display_signs
    HoroscopesCLI::ZodiacSign.all.each do |signs|
      puts "#{signs.sign}"
      puts " #{signs.sign_dates}"
      puts " #{signs.url}"
      puts "#{signs.horoscope}"
      puts " #{signs.today_date}"
      puts " #{signs.love_scope}"
     end
  end
  
  def welcomeUser
    puts "welcome to Horoscopes CLI, giving you your daily advice from the stars"
  end 
  
  def askSign
    puts "Do you know your sign?(yes/no)"
    input = gets.strip
    if input == "yes"
      puts "Could you tell me what your sign is? Be respectful of your zodiac, and remember to capitalize it's name."
      @@userSign = gets.strip 
    elsif input == "no"
        puts "I'm going to give you a list of signs and their birthdays"
        HoroscopesCLI::ZodiacSign.all.each do |zsign|
       puts "#{zsign.sign_name} are born from #{zsign.sign_dates}"
         end 
        puts "Please tell me your sign. Be respectful of your zodiac, and remember to capitalize it's name."
        @@userSign = gets.strip
    end 
    puts "Ah... I thought you were a #{@@userSign}."
  end 
  
  def findUserSign
    puts "Please tell me your birthday. Please giv the first 3 letters of the month you were born in, and the two digit day. For example: if your birthday was September 16, 1990, you would type Sep 16."
    bday = gets.strip 
    month = bday[0...2]
    day = day[4...5].to_i 
      if bday.starts_with?("May") && bday.ends_with?()
        
      end 
    end 
  
  def currentSign
    HoroscopesCLI::ZodiacSign.find_by_sign(@@userSign)
  end 
  
  def daily 
    puts "Would you like to hear your daily general horoscope?"
    input = gets.strip
      if input == "yes" 
        puts "#{currentSign.horoscope}"
      else 
        puts "okay... moving on"
      end 
  end 
  
  def loveScope
    puts "Would you like to hear your daily love horoscope?"
    input = gets.strip
    if input == "yes" 
      puts "#{currentSign.love_scope}"
    else 
      puts "That's okay. Some things are better left unknown."
    end 
  end 
    
    
  def bye 
    puts "Check back tomorrow for more from the stars"
  end 
  
end 


