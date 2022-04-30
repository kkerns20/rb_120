class Person
  attr_reader :name
  attr_writer :secret
  attr_accessor :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def introduce
    puts "Hi, my name is #{name}!"  # we can access @name through a getter
  end
  
  def have_a_birthday
    self.age += 1                   # we can change @age through a setter
  end
end

john = Person.new('John', 30)

# We can access @name through a getter, but cannot change it through a setter
john.introduce                      # => Hi, my name is John!
john.name                           # => 'John'
john.name = 'Johnny'                # => NoMethodError

# We can assign @secret through a setter, but cannot access it through a getter
john.secret = 'afraid of clowns'    # Appends 'afraid of clowns' to @secret
john                                # => #<Person:0x0000561b2b42ac88 @age=30, @name="John", @secret="afraid of clowns">
john.secret                         # => NoMethodError

# We can both access and reassign @age because it has both a getter and a setter
john.age                            # => 30
john.have_a_birthday
john.age                            # => 31