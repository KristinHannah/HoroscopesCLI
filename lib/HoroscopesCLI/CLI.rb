
class HoroscopesCLI::CLI 
  attr_accessor :userSign
  
  def call
    makeSigns
    add_attributes
    welcomeUser
    display_signs
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
      puts "#{signs.sign_name}"
     end
     askSign
  end
  
  def userSign=(sign)
    @userSign = sign
  end 
  
  def userSign
    @userSign
  end 
  
  def welcomeUser
    puts "welcome to Horoscopes CLI, giving you your daily advice from the stars"
  end 
  
  def askSign
    puts "Do you know your sign?(yes/no)"
    input = gets.strip
    if input == "yes"
      puts "Could you tell me what your sign is? Be respectful of your zodiac, and remember to capitalize it's name."
      @userSign = gets.strip 
    elsif input == "no"
      findUserSign
     #   puts "I'm going to give you a list of signs and their birthdays"
     #   HoroscopesCLI::ZodiacSign.all.each do |zsign|
    #   puts "#{zsign.sign_name} are born from #{zsign.sign_dates}"
     #    end 
     #   puts "Please tell me your sign. Be respectful of your zodiac, and remember to capitalize it's name."
    #    @@userSign = gets.strip
    end 
    puts "Ah... I thought you were a #{@userSign}."
  end 
  
  def findUserSign
    puts "Please tell me your birthday. Please giv the first 3 letters of the month you were born in, and the day. For example: if your birthday was September 16, 1990, you would type Sep 16."
    bday = gets.strip 
    bdaysplit = bday.split(" ")
    month = bdaysplit[0]
    day = bdaysplit[1].to_i 
      if month == "May" && day.between?(21, 31) || month == "June" && day.between?(1, 20)
        puts "You are a Gemini"
        @userSign = "Gemini"
      elsif month == "March" && day.between?(21, 31)  || month == "April" && day.between?(1, 19)
        puts "You are a Aries"
        @userSign = "Aries"
      elsif month == "April" && day.between?(20, 30) || month == "May" && day.between?(1, 20)
        puts "You are a Taurus"
        @userSign = "Taurus"
      elsif month == "June" && day.between?(21, 31) || month == "July" && day.between?(1, 22)
        puts "You are a Cancer"
        @userSign = "Cancer"
     elsif month == "July" && day.between?(23, 31) || month == "August" && day.between?(1, 22)
        puts "You are a Leo"
        @userSign = "Leo"
    elsif month == "August" && day.between?(23, 31) || month == "September" && day.between?(1, 22)
        puts "You are a Virgo"
        @userSign = "Virgo"
    elsif month == "September" && day.between?(23, 31) || month == "October" && day.between?(1, 22)
        puts "You are a Libra"
        @userSign = "Libra"
    elsif month == "October" && day.between?(23, 31) || month == "November" && day.between?(1, 21)
        puts "You are a Scorpio"
        @userSign = "Scorpio"
     elsif month == "November" && day.between?(22, 31) || month == "December" && day.between?(1, 21)
        puts "You are a Sagittarius"
        @userSign = "Sagittarius"
    elsif month == "December" && day.between?(22, 31) || month == "January" && day.between?(1, 19)
        puts "You are a Capricorn"
        @userSign = "Capricorn"
    elsif month == "January" && day.between?(20, 31) || month == "February" && day.between?(1, 18)
        puts "You are a Aquarius"
        @userSign = "Aquarius"
    elsif month == "February" && day.between?(19, 29) || month == "March" && day.between?(1, 20)
        puts "You are a Pisces"
        @userSign = "Pisces"
      end 
    end 
  
  def currentSign
    HoroscopesCLI::ZodiacSign.find_by_sign(@userSign)
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


