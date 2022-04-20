class Tiger
  # class variable pertinent to all objects across class
  @@scientific_name = 'panthera tigris'

  def self.scientific_name
    @@scientific_name       # accessible from class method
  end

  def initialize(breed)
    # instance variable pertinent to individual object
    @breed = breed
  end

  def what_am_i
    # both instance and class variables accessible from instance methods
    puts "I'm a #{@breed} from the #{@@scientific_name} species"
  end
end

tony = Tiger.new('bengal')
tigger = Tiger.new('sumatran')

p tony
p tigger

tony.what_am_i
tigger.what_am_i