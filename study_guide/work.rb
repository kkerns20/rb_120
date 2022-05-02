# a method defined within a class is public by default
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def introduce
    puts "Hi, my name is #{name}"
  end
end

# we can call public methods anywhere within the program
rhone = Person.new('Rhone')

# we can call public methods anywhere within the program
rhone.name        # => 'Rhone'
rhone.introduce   # => "Hi, my name is Rhone"