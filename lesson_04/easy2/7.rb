class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explaing cats_count and how it works
# What code would test your theory?

=begin
`@@cats_count` is a class variable, and it is used to 
count the amount of instances of the `Cat` class that are
instantiated.

If we called `Cats.cats_count`, it would return the number
of instances created of the `Cat` class

OR we could print the value of `@@cats_count` variable to the screen
after it has been incremented from within the `intialize` method definition
=end