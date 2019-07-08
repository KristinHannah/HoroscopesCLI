
class HoroscopesCLI::CLI 
  
  def call
    makeSigns
    add_attributes
    display_signs
    # welcomeUser
   # askBday
  #  daily 
  #  loveScope
  #  bye
  end 
  
  def makeSigns 
    signs_array = HoroscopesCLI::Scraper.scrape_index_page
    HoroscopesCLI::ZodiacSign.create_from_collection(signs_array)
  end 
  
  def add_attributes 
    HoroscopesCLI::ZodiacSign.all.each do |sign|
     attributes = HoroscopesCLI::Scraper.scrape_info(sign.url)
     HoroscopesCLI::ZodiacSign.add_attributes(attributes)
  end
  end 
  
   def display_signs
    ZodiacSign.all.each do |signs|
      puts "#{ZodiacSign.sign}"
      puts " #{ZodiacSign.sign_dates}"
      puts " #{ZodiacSign.url}"
      puts "#{ZodiacSign.horoscope}"
      puts " #{ZodiacSign.today_date}"
     end
  end
  
  def welcomeUser
    puts "welcome to Horoscopes CLI, giving you your daily advice from the stars"
  end 
  
  def askBday
    puts "Tell me your birthday to learn your sign. Please input your birthday with the two digit month and two digit day (August 25 would be 08/25)."
    HoroscopesCLI::ZodiacSign.all
     input = gets.strip 
      case input 
        when "08/25"
          puts "virgo"
        when "12/07"
          puts "sagitarrius"
      end 
  end 
  
  def daily 
    puts "Would you like to hear your daily general horoscope?"
    input = gets.strip
      if input == "yes" 
        puts "here is your general horoscope"
      else 
        puts "okay... moving on"
      end 
  end 
  
  def loveScope
    puts "Would you like to hear your daily love horoscope?"
    input = gets.strip
    if input == "yes" 
      puts "here is your love scope"
    else 
      puts "That's okay. Some things are better left unknown."
    end 
  end 
    
    
  def bye 
    puts "Check back tomorrow for more from the stars"
  end 
  
end 


