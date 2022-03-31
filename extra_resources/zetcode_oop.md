# ZetCode Ruby OOP Part 1

*Object-oreinted programming (OOP)*
: a programming paradigm that uses objects and their interactions to design applications and computer programs.

The basic programming concepts in OOP are:
  - Abstraction
  - Polymorphism
  - Encapsulation
  - Inheritance

*abstraction*
: simplifying complex reality by modeling classes appropriate to the problem

*polymorphism* 
: the process of using an operator or function in differnt ways for different data input

*encapsulation*
: hides the implementation details of a class from other objects

*inheritance*
: a way to form new classes using classes that have already been defined


## Ruby super method ##

The super method calls a method of the same name in the parent's class. If the method has no arguments it automatically passes all its arguments. If we write super no arguments are passed to parent's method.

```ruby
class Base

  def show x=0, y=0
      p "Base class, x: #{x}, y: #{y}"
  end
end

class Derived < Base

  def show x, y
      super       # passes along all arguments
      super x     # just passes along x argument
      super x, y  # passes along two arguments
      super()     # passes no arguments 
                  # <- must do this is your intent is not arguments to pasee
  end
end


d = Derived.new
d.show 3, 3

=begin
Output:
"Base class, x: 3, y: 3"
"Base class, x: 3, y: 0"
"Base class, x: 3, y: 3"
"Base class, x: 0, y: 0"
  
=end
```

## Ruby attribute accessors

`attr_reader` 
: creates getter methods
`attr_writer`
:creates setter methods and instance variables
```ruby
class Car

    attr_reader :name, :price
    # Here we create two instance methods named name and price. Note that the attr_reader takes symbols of methods as parameters.
    attr_writer :name, :price
    # The attr_writer creates two setter methods named name and price and two instance variables, @name and @price.
    def to_s
        "#{@name}: #{@price}"
    end

end


c1 = Car.new
c2 = Car.new

c1.name = "Porsche"
c1.price = 23500
# In this context, two setter methods are called to fill instance variables with some data.
c2.name = "Volkswagen"
c2.price = 9500

puts "The #{c1.name} costs #{c1.price}"
# Here two getter methods are called to get data from the instance variables of the c1 object.
puts c1
puts c2

=begin
The Porsche costs 23500
Porsche: 23500
Volkswagen: 9500
=end
```

`attr_accessor`
: creates both getter, setter methods and their instance variables

```ruby
class Car

    attr_reader :name, :price
    attr_writer :name, :price

    def to_s
        "#{@name}: #{@price}"
    end

end


c1 = Car.new
c2 = Car.new

c1.name = "Porsche"
c1.price = 23500

c2.name = "Volkswagen"
c2.price = 9500

puts "The #{c1.name} costs #{c1.price}"

puts c1
puts c2
```

## to_s method

The reason we override the `to_s` method is to provide a human-readabl description of our object.

```ruby
class Being

    def to_s
        "This is Being class"
    end
end

b = Being.new
puts b.to_s
puts b
# We create a Being class and call the to_s method twice. The first time explicitly, the second time implicitly.
```

## Ruby operator overloading ##

Operator overloading
: a situation where different operators have different implementations depending on thier arguments

```ruby
class Circle

    attr_accessor :radius

    def initialize r
        @radius = r
    end

    #  We overload the + operator in the class. We use it to add two circle objects.
    def +(other)
        # We define a method with a + name. The method adds the radiuses of two circle objects.
        Circle.new @radius + other.radius
    end

    def to_s
        "Circle with radius: #{@radius}"
    end
end


c1 = Circle.new 5
c2 = Circle.new 6
c3 = c1 + c2

puts c3
```

## Class methods ##

There are three ways to create a class method in Ruby.
```ruby
class Wood
    # Class methods may start with a self keyword.
    def self.info
       "This is a Wood class"
    end
end

class Brick
    # Another way is to put a method definition after the class << self construct.
    class << self
        def info
           "This is a Brick class"
        end
    end
end

class Rock

end
# Third way is to call the method name after the class
def Rock.info
   "This is a Rock class"
end


p Wood.info
# => "This is a Wood class"
p Brick.info
# => "This is a Brick class"
p Rock.info
# => "This is a Rock class"
```

## Creating instance methods ##

There are also three basic ways to create instance methods, which belond to the instance of an object. They are called with a dot operator.

```ruby
class Wood
    # This is the most common way to define and call an instance method
    # with the object being created and calling infor method on the object instance below
    def info
       "This is a wood object"
    end
end

wood = Wood.new
p wood.info
# => "This is a wood object"

class Brick

    attr_accessor :info
end
# The brick object is created and the data is stored in the @info variable using the info setter method. Finally, the message is read by the info getter method.
brick = Brick.new
brick.info = "This is a brick object"
p brick.info
# => "This is a brick object"

class Rock

end

rock = Rock.new

def rock.info
    "This is a rock object"
end
# In the third way we create an empty Rock class. The object is instantiated. Later, a method is dynamically created and placed into the object.
p rock.info
# => "This is a rock object"
```

## Polymorphism ##

```ruby
class Animal

    def make_noise
        "Some noise"
    end

    def sleep
        puts "#{self.class.name} is sleeping."
    end

end

class Dog < Animal

    def make_noise
        'Woof!'
    end

end

class Cat < Animal

    def make_noise
        'Meow!'
    end
end

[Animal.new, Dog.new, Cat.new].each do |animal|
  puts animal.make_noise
  animal.sleep
end
=begin
=> Some noise
=> Animal is sleeping.
=> Woof!
=> Dog is sleeping.
=> Meow!
=> Cat is sleeping.
=end
```

## Modules

A Ruby Module 
: a collection of methods, classes, and constants. Modules are similar to classes with a few differences, as modules cannot have instances and cannot subclasses.

Modules suport the use of mixins in Ruby.
*mixin*
: a Ruby facility to create *multiple inheritance*

```ruby
# there is a built in Math module in Ruby
# access PI with the `::` operator
puts Math::PI
# methods accessed with dot operator
puts Math.sin 2

# If we include a module in our script, we can refer to the Math
# objects directly, ommitting the Math name
# modules are added using the `include` keyword
include Math

puts PI
puts sin 2
```

```ruby
module Forest

    class Rock ; end
    class Tree ; end
    class Animal ; end

end

module Town

   class Pool ; end
   class Cinema ; end
   class Square ; end
   class Animal ; end

end

# To access an object in a module, we use the :: operator.
p Forest::Tree.new
#<Forest::Tree:0x97f35ec>
p Forest::Rock.new
#<Forest::Rock:0x97f35b0>
p Town::Cinema.new
#<Town::Cinema:0x97f3588>

# We couldn't define two animal classes, but putting them in different modules solve the issue
p Forest::Animal.new
#<Forest::Animal:0x97f3560>
p Town::Animal.new
#<Town::Animal:0x97f3538>
```

```ruby
module Device
    def switch_on ; puts "on" end
    def switch_off ; puts "off" end
end

module Volume
    def volume_up ; puts "volume up" end 
    # interesting way to define a method
    def vodule_down ; puts "volume down" end
end

module Pluggable
    def plug_in ; puts "plug in" end
    def plug_out ; puts "plug out" end
end

class CellPhone
    include Device, Volume, Pluggable

    def ring
        puts "ringing"
    end
end

cph = CellPhone.new
cph.switch_on
# => on
cph.volume_up
# => volume up
cph.ring
# => ringing
```

## Exceptions ##

exceptions
: objects that signal deviations from the normal flow of program execution. Exceptions are raised, thrown, or initiated.

Exceptions are objects. They are descendants of a built-in Exception class. Exception objects carry information about the exception. Its type (the exception’s class name), an optional descriptive string, and optional traceback information. Programs may subclass Exception, or more often StandardError, to obtain custom Exception objects that provide additional information about operational anomalies.

```ruby
x = 35
y = 0
# we initentionally divide by 0
begin
    z = x / y
    puts z
    # statements that fail are placed after the begin keyword
rescue => e # `e` is an exception object that is created when the exception occurs
    puts e
    p e
    # after the rescue keyword, we deal with the exception
    # here, we print the error message to the console
end
# divided by 0
# <ZeroDivisionError: divided by 0>
```

Ruby's ensure clause creates a block of code that always executes, whether there is an exception or not.

```txt
# stones.txt
Garnet
Topaz
Opal
Amethyst
Ruby
Jasper
Pyrite
Malachite
Quartz
```
```ruby
begin
    f = File.open("stones.txt", "r")
    # We try to open and read the stones files above
    while line = f.gets do
        puts line
    end

rescue => e
    puts e
    p e

ensure
    f.close if f
end
# In the ensure block we close the file handler. We check if the handler exists because it might not have been created. Allocated resources are often placed in the ensure block.
```

We can also create our own custom exceptions if we want. Custom exceptions should inherit from the StandardError class.

```ruby
class BigValueError < StandardError ; end

LIMIT = 333
x = 3_432_453

begin

    if x > LIMIT
        raise BigValueError, "Exceeded the maximum value"
    end

    puts "Script continues"

rescue => e

    puts e
    p e
    exit 1
end

# Exceeded the maximum value
#<BigValueError: Exceeded the maximum value>
```