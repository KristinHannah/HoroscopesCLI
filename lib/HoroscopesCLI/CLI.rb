class HoroscopesCLI::CLI 
  attr_accessor :user_sign
  
  #userSign Methods 
  
  def current_sign
    HoroscopesCLI::ZodiacSign.find_by_sign(@user_sign)
  end 
  
  #call method 
  
  def call
    make_signs
    welcome_user
  end 
  
  #scraping methods
  
  def make_signs 
    signs_array = HoroscopesCLI::Scraper.new.scrape_index_page
    HoroscopesCLI::ZodiacSign.create_from_collection(signs_array)
  end 
  
  def add_attributes(sign)
    HoroscopesCLI::ZodiacSign.check_scope_att(sign)
  end 
  
  #reused input methods
  
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
      puts "Could you tell me what the sign is?".colorize(:magenta)
            sign = gets.strip.downcase
            if HoroscopesCLI::ZodiacSign.find_by_sign(sign)
              @user_sign = sign 
              add_attributes(sign)
              puts "Ah... I thought this was a #{@user_sign}.".colorize(:magenta)
              horoscope_choice
            else 
             puts "hmm.. Let's try again".colorize(:magenta)
            ask_sign
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
           puts "Ah... I thought we were talking about a #{@user_sign}.".colorize(:magenta)
          horoscope_choice
        end 
    elsif user_exit?(input)
      exit_program
    else 
      puts "I'm not sure I know what you mean.".colorize(:magenta)
      ask_sign
    end 
  end 
              
  def find_user_sign
    puts "Please tell me the birthday of the person's sign you'd like to check. Give the full name of the month, and the day. For example: August 25, May 2".colorize(:magenta)
    bday = gets.strip 
    @bday = bday
    bdaysplit = bday.split(" ")
    month = bdaysplit[0]
    day = bdaysplit[1].to_i 
      if month == "May" && day.between?(21, 31) || month == "June" && day.between?(1, 20)
        @user_sign = "gemini"
      elsif month == "March" && day.between?(21, 31)  || month == "April" && day.between?(1, 19)
        @user_sign = "aries"
      elsif month == "April" && day.between?(20, 30) || month == "May" && day.between?(1, 20)
        @user_sign = "taurus"
      elsif month == "June" && day.between?(21, 31) || month == "July" && day.between?(1, 22)
       @user_sign = "cancer"
     elsif month == "July" && day.between?(23, 31) || month == "August" && day.between?(1, 22)
        @user_sign = "leo"
    elsif month == "August" && day.between?(23, 31) || month == "September" && day.between?(1, 22)
        @user_sign = "virgo"
    elsif month == "September" && day.between?(23, 31) || month == "October" && day.between?(1, 22)
        @user_sign = "libra"
    elsif month == "October" && day.between?(23, 31) || month == "November" && day.between?(1, 21)
        @user_sign = "scorpio"
     elsif month == "November" && day.between?(22, 31) || month == "December" && day.between?(1, 21)
        @user_sign = "sagittarius"
    elsif month == "December" && day.between?(22, 31) || month == "January" && day.between?(1, 19)
        @user_sign = "capricorn"
    elsif month == "January" && day.between?(20, 31) || month == "February" && day.between?(1, 18)
        @user_sign = "aquarius"
    elsif month == "February" && day.between?(19, 29) || month == "March" && day.between?(1, 20)
        @user_sign = "pisces"
    elsif bday == "exit" || bday == "exit"
    else 
      puts "I didn't quite get that. Are you sure you capitalized the month and spelled it correctly?".colorize(:magenta)
      find_user_sign
      end 
     add_attributes(@user_sign)
    end 
    
  def horoscope_choice
    puts "Would you like to hear the general horoscope, love horoscope or both for #{current_sign.sign_name} on #{current_sign.today_date}?(general/love/both)".colorize(:magenta)
    input = gets.strip 
     if input == "general" || input == "General" 
        puts "#{current_sign.horoscope}".colorize(:magenta)
        check_another_sign
      elsif input == "love" || input == "Love"
        puts "#{current_sign.love_scope}".colorize(:magenta)
        check_another_sign
      elsif input == "both" || input == "Both"
        puts "Here is the general horoscope: #{current_sign.horoscope}".colorize(:magenta)
        puts "Here is the love horoscope: #{current_sign.love_scope}".colorize(:magenta)
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
          puts "Ooh.. a #{user_sign}.".colorize(:magenta)
         horoscope_choice
        end 
    else 
      puts "The stars might understand you, but I sure don't".colorize(:magenta)
      new_sign
    end 
    input = nil 
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


