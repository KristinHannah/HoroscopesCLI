class HoroscopesCLI::ZodiacSign 
  attr_accessor :sign_name, :sign_dates, :url, :horoscope, :love_link, :today_date, :love_scope
  @@all = []
  
  def initialize(sign_hash)
    sign_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end 
  
  def self.all
    @@all
  end 
  
  def save 
    @@all << self
  end 
  
  def self.create_from_collection(signs_array)
      signs_array.each do |attr|
      self.new(attr)
    end 
  end 
  
  def add_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end
  
  def self.find_by_sign(sign)
    self.all.find {|s| s.sign_name == sign}
  end 
end 