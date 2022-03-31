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