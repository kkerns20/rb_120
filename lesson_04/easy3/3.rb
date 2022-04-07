# When objects are created they are a separate realization of a particular class.
# create two different instances of this class with separate names and ages

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end
# we create the `AngryCat` objects when we pass the constructor two values
# an age and name.
# These are assigned to the new object's instance variables, and each
# ends up with different information.
garfield = AngryCat.new(12, 'Garfield')
tibber = AngryCat.new(9, "Mr. Tibbs")
# We can test with...
garfield.name
garfield.age
tibber.name
tibber.age