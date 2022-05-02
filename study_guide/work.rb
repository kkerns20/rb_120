class Superhero
  def initialize(name)
    @name = name
  end

  # this method will be part of the puhlic interface for Person
  def introduce
    puts "I'm #{name}!"
  end

  private

  # here, we define our @name getter/setter to be private
  attr_accessor :name
end

bruce = Superhero.new('Batman')

# we can call public methods anywhere...
bruce.introduce         # => I'm Batman!

# however private methods only work inside the class
bruce.name              # => NoMethodError: private method `name` called...