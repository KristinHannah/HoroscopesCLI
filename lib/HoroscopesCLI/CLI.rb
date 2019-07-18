class HoroscopesCLI::CLI 
  attr_accessor :user_sign
  
  #userSign Methods 
  
  def current_sign
    HoroscopesCLI::ZodiacSign.find_by_sign(@user_sign)
  end 
  
  #call method 
  
  def call
    make_signs
   # add_attributes
    welcome_user
  end 
  
  #scraping methods
  
  def make_signs 
    signs_array = HoroscopesCLI::Scraper.new.scrape_index_page
    HoroscopesCLI::ZodiacSign.create_from_collection(signs_array)
  end 
  
#make it so this isn't called until user makes a selection, check if the attributes are there- if not scrape them
#change to snake_case
#slack by end of day Friday 

  def add_attributes(sign)
    HoroscopesCLI::ZodiacSign.check_scope(sign)
  end 
  
  
  def add_attributes1 
    HoroscopesCLI::ZodiacSign.all.each do |sign|
     attributes = HoroscopesCLI::Scraper.scrape_info(sign)
     sign.add_attributes(attributes)
     love_atts = HoroscopesCLI::Scraper.scrape_love_info(sign)
     sign.add_attributes(love_atts)
  end
  end 
  
  #methods the user interacts with
  
  def welcome_user
    puts "Welcome to Horoscopes CLI, giving you your daily advice from the stars. Would you like to see a list of the zodiac signs?(yes/no)".colorize(:magenta)
    input = gets.chomp 
    if yes?(input)
      display_signs
    elsif no?(input)
      ask_sign 
    elsif user_exit?(input)
      exit_program
    else 
      puts "Let's try that again...".colorize(:magenta)
      welcome_user
    end 
  end 
  
  def display_signs
     puts "Here is a list of the zodiac signs:".colorize(:magenta)
     HoroscopesCLI::ZodiacSign.all.each do |signs|
      puts "#{signs.sign_name}".colorize(:magenta)
     end
     ask_sign
  end
  
  def yes?(input)
    if input == "yes" || input == "Yes" || input == "y" 
      true 
    else 
      false 
    end 
  end 
  
  def no?(input)
    if input == "no" || input == "No" || input == "n" 
      true 
    else 
      false 
    end 
  end 
  
  def user_exit?(input)
   if input == "exit" || input == "Exit"
     true 
   else 
     false 
    end 
  end 
  
  def sign_prompt
      puts "Could you tell me what your sign is?".colorize(:magenta)
            sign = gets.strip
            if HoroscopesCLI::ZodiacSign.find_by_sign(sign)
              @user_sign = sign 
              add_attributes(sign)
              puts "Ah... I thought you were a #{@user_sign}.".colorize(:magenta)
              horoscope_choice
            else 
             puts "hmm.. Let's try again".colorize(:magenta)
            ask_sign
            end 
  end 
  
  def ask_sign
    puts "Do you know your sign?(yes/no)".colorize(:magenta)
    input = gets.strip
    if yes?(input)
        sign_prompt
    elsif no?(input)
      find_user_sign
        if @bday == "exit" || @bday == "exit"
          exit_program
        else 
           puts "Ah... I thought you were a #{@userSign}.".colorize(:magenta)
          horoscope_choice
        end 
    elsif user_exit?(input)
      exit_program
    else 
      puts "I'm not sure I know what you mean.".colorize(:magenta)
      ask_sign
    end 
  end 
  
  def new_sign
    puts "Do you know the sign of the person whose horoscope you want to check?(yes/no)".colorize(:magenta)
      input = gets.strip
     if yes?(input)
      sign_prompt
    elsif no?(input)
      find_user_sign
        if @bday == "exit" || @bday == "exit"
          exit_program
        else 
          puts "Ooh.. a #{userSign}.".colorize(:magenta)
         horoscope_choice
        end 
    else 
      puts "The stars might understand you, but I sure don't".colorize(:magenta)
      new_sign
    end 
    input = nil 
  end 
  
  def find_user_sign
    puts "Please tell me the birthday of the person's sign you'd like to check. Give the full name of the month, and the day. For example: August 25, May 2".colorize(:magenta)
    bday = gets.strip 
    @bday = bday
    bdaysplit = bday.split(" ")
    month = bdaysplit[0]
    day = bdaysplit[1].to_i 
      if month == "May" && day.between?(21, 31) || month == "June" && day.between?(1, 20)
        @userSign = "Gemini"
      elsif month == "March" && day.between?(21, 31)  || month == "April" && day.between?(1, 19)
        @userSign = "Aries"
      elsif month == "April" && day.between?(20, 30) || month == "May" && day.between?(1, 20)
        @userSign = "Taurus"
      elsif month == "June" && day.between?(21, 31) || month == "July" && day.between?(1, 22)
        @userSign = "Cancer"
     elsif month == "July" && day.between?(23, 31) || month == "August" && day.between?(1, 22)
        @userSign = "Leo"
    elsif month == "August" && day.between?(23, 31) || month == "September" && day.between?(1, 22)
        @userSign = "Virgo"
    elsif month == "September" && day.between?(23, 31) || month == "October" && day.between?(1, 22)
        @userSign = "Libra"
    elsif month == "October" && day.between?(23, 31) || month == "November" && day.between?(1, 21)
        @userSign = "Scorpio"
     elsif month == "November" && day.between?(22, 31) || month == "December" && day.between?(1, 21)
        @userSign = "Sagittarius"
    elsif month == "December" && day.between?(22, 31) || month == "January" && day.between?(1, 19)
        @userSign = "Capricorn"
    elsif month == "January" && day.between?(20, 31) || month == "February" && day.between?(1, 18)
        @userSign = "Aquarius"
    elsif month == "February" && day.between?(19, 29) || month == "March" && day.between?(1, 20)
        @userSign = "Pisces"
    elsif bday == "exit" || bday == "exit"
    else 
      puts "I didn't quite get that. Are you sure you capitalized the month and spelled it correctly?".colorize(:magenta)
      find_user_sign
      end 
    end 
    
  def horoscope_choice
    puts "Would you like to hear the general horoscope, love horoscope or both for #{current_sign.today_date}?(general/love/both)".colorize(:magenta)
    input = gets.strip 
     if input == "general" || input == "General" 
        puts "#{currentSign.horoscope}".colorize(:magenta)
        checkAnotherSign
      elsif input == "love" || input == "Love"
        puts "#{currentSign.love_scope}".colorize(:magenta)
        checkAnotherSign
      elsif input == "both" || input == "Both"
        puts "Here is your general horoscope: #{currentSign.horoscope}".colorize(:magenta)
        puts "Here is your love horoscope: #{currentSign.love_scope}".colorize(:magenta)
        check_another_sign
      elsif input == "exit" || input == "Exit"
        exit_program
      else 
       puts "I'm not sure what you're trying to tell me...".colorize(:magenta)
       horoscope_choice
     end 
   end 
    
  def check_another_sign
    puts "Would you like to check the horoscope for another sign?(yes/no)".colorize(:magenta)
      input = gets.strip 
    if yes?(input)
      new_sign
    elsif input == "no" || input == "No" || input == "n" || input == "exit" || input == "Exit"
      exit_program 
    else 
      puts "I'm not sure what you mean...".colorize(:magenta)
      check_another_sign
    end 
  end 
  
  def exit_program
    puts "Would you like to exit the program?(yes/no)".colorize(:magenta)
    input = gets.strip
    if yes?(input)
      bye 
    elsif no?(input)
     check_another_sign
   end 
  end   
    
  def bye 
    puts "Check back tomorrow for more from the stars".colorize(:magenta)
  end 
  
end 


