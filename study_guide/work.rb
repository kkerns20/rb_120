class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  def has_a_birthday
    # call private setter method to increment @age within the class
    self.age += 1
  end

  def how_old
    # call private getter method for desired output/protect sensitive info
    puts "I am #{age - 3} years old"
  end

  def introduce
    # call private getter method to format @name correctly
    puts "Hi my name is #{name.capitalize}"
  end

  private

  attr_reader :name
  attr_accessor :age
end

wit = Person.new('Wit', 0)

wit.introduce       # => Hi my name is Wit
wit.has_a_birthday  # increments @age
wit.has_a_birthday  # increments @age
wit.has_a_birthday  # increments @age
wit.has_a_birthday  # increments @age
wit.how_old         # => I am 1 years old