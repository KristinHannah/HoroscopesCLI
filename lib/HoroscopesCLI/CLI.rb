
class HoroscopesCLI::CLI 
  attr_accessor :userSign
  
  #userSign Methods 
  def userSign=(sign)
    @userSign = sign
  end 
  
  def userSign
    @userSign
  end 
  
  def currentSign
    HoroscopesCLI::ZodiacSign.find_by_sign(@userSign)
  end 
  
  #call method 
  
  def call
    makeSigns
    add_attributes
    welcomeUser
  end 
  
  #scraping methods
  
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
  
  #methods the user interacts with
  
  def welcomeUser
    puts "Welcome to Horoscopes CLI, giving you your daily advice from the stars. Would you like to see a list of the zodiac signs?(yes/no)"
    input = gets.chomp 
    if input == "yes" || input == "Yes" || input == "y"
      display_signs
    elsif input == "no" || input == "No" || input == "n"
      askSign 
    elsif input == "exit" || input == "Exit"
      exitProgram
    else 
      puts "Let's try that again..."
      welcomeUser
    end 
  end 
  
  def display_signs
     puts "Here is a list of the zodiac signs:"
    HoroscopesCLI::ZodiacSign.all.each do |signs|
      puts "#{signs.sign_name}"
     end
     askSign
  end
  
  def askSign
    puts "Do you know your sign?(yes/no)"
    input = gets.strip
    if input == "yes" || input == "Yes" || input == "y" 
      puts "Could you tell me what your sign is? Be respectful of the zodiac, and remember to capitalize it's name."
      @userSign = gets.strip 
      puts "Ah... I thought you were a #{@userSign}."
    #  dailyScope
      horoscopeChoice
    elsif input == "no" || input == "No" || input == "n"
      findUserSign
        if @bday == "exit" || @bday == "exit"
          exitProgram
        else 
           puts "Ah... I thought you were a #{@userSign}."
          #dailyScope
          horoscopeChoice
        end 
    elsif input == "exit" || input == "Exit"
      exitProgram
    else 
      puts "I'm not sure I know what you mean."
      askSign
    end 
  end 
  
  def newSign
    puts "Do you know the sign of the person whose horoscope you want to check?(yes/no)"
      input = gets.strip
     if input == "yes" || input == "Yes" || input == "y" 
      puts "Could you tell me what the sign is? Be respectful of the zodiac, and remember to capitalize it's name."
      @userSign = gets.strip 
      puts "Ooh.. a #{userSign}."
     horoscopeChoice
    elsif input == "no" || input == "No" || input == "n"
      findUserSign
        if @bday == "exit" || @bday == "exit"
          exitProgram
        else 
          puts "Ooh.. a #{userSign}."
         horoscopeChoice
        end 
    else 
      puts "The stars might understand you, but I sure don't"
      newSign
    end 
    input = nil 
  end 
  
  def findUserSign
    puts "Please tell me the birthday of the person's sign you'd like to check. Give the full name of the month, and the day. For example: August 25, May 2"
    bday = gets.strip 
    @bday = bday
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
    elsif bday == "exit" || bday == "exit"
    else 
      puts "I didn't quite get that. Are you sure you capitalized the month and spelled it correctly?"
      findUserSign
      end 
    end 
    
  def horoscopeChoice
    puts "Would you like to hear your general horoscope, love horoscope or both?(general/love/both)"
    input = gets.strip 
     if input == "general" || input == "General" 
        puts "#{currentSign.horoscope}"
        checkAnotherSign
      elsif input == "love" || input == "Love"
        puts "#{currentSign.love_scope}"
        checkAnotherSign
      elsif input == "both" || input == "Both"
        puts "Here is your general horoscope: #{currentSign.horoscope}"
        puts "Here is your love horoscope: #{currentSign.love_scope}"
        checkAnotherSign
      elsif input == "exit" || input == "Exit"
        exitProgram
      else 
       puts "I'm not sure what you're trying to tell me..."
       horoscopeChoice
     end 
   end 
    
  def dailyScope
    puts "Would you like to hear the daily general horoscope for #{userSign}?(yes/no)"
    input = gets.strip
      if input == "yes" || input == "Yes" || input == "y" 
        puts "#{currentSign.horoscope}"
        loveScope
      elsif input == "no" || input == "No" || input == "n" 
        puts "okay... moving on"
        loveScope
      elsif input == "exit" || input == "Exit"
        exitProgram
      else 
       puts "I'm not sure what you're trying to tell me..."
       loveScope
      end 
  end 
  
  def loveScope
    puts "Would you like to hear the daily love horoscope for #{userSign}?(yes/no)"
    input = gets.strip
    if input == "yes" || input == "Yes" || input == "y" 
      puts "#{currentSign.love_scope}"
      checkAnotherSign
    elsif input == "no" || input == "No" || input == "n" 
      puts "That's okay. Some things are better left unknown."
      checkAnotherSign
    elsif input == "exit" || input == "Exit"
      exitProgram
    else 
      puts "I'm not sure what you're trying to tell me..."
      loveScope
    end 
  end 
  
  def checkAnotherSign
    puts "Would you like to check the horoscope for another sign?(yes/no)"
      input = gets.strip 
    if input == "yes" || input == "Yes" || input == "y" 
      newSign
    elsif input == "no" || input == "No" || input == "n" || input == "exit" || input == "Exit"
      exitProgram 
    else 
      puts "I'm not sure what you mean..."
      checkAnotherSign
    end 
  end 
  
  def exitProgram
    puts "Would you like to exit the program?(yes/no)"
    input = gets.strip
    if input == "yes" || input == "Yes" || input == "y" 
      bye 
    elsif input == "no" || input == "No" || input == "n"
     checkAnotherSign
   end 
  end   
    
  def bye 
    puts "Check back tomorrow for more from the stars"
  end 
  
end 


