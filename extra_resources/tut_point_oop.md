# Tutorials Point - Ruby OOP

Much of this material is covered in the companion [ruby file](./tut_point_oop.rb)

- [Operator Overloading](#operator-overloading)
- [Freezing Objects](#freezing-objects)

## Operator Overloading ##

We'd like the + operator to perform vector addition of two Box objects using +, the * operator to multiply a Box width and height by a scalar, and the unary - operator to do negate the width and height of the Box. Here is a version of the Box class with mathematical operators defined −
```ruby
class Box
   def initialize(w,h)     # Initialize the width and height
      @width,@height = w, h
   end

   def +(other)       # Define + to do vector addition
      Box.new(@width + other.width, @height + other.height)
   end

   def -@           # Define unary minus to negate width and height
      Box.new(-@width, -@height)
   end

   def *(scalar)           # To perform scalar multiplication
      Box.new(@width*scalar, @height*scalar)
   end
end
```

## Freezing Objects ##

When we want to prevent an object from being changed, we use the Object#freeze method, effectively turning an object into a constant. A frozen object may not be modified: you cannot change its instance variables.

You can check if an object is frozen with Object#frozen? which returns a boolean

```ruby
# define a class
class Box
   # constructor method
   def initialize(w,h)
      @width, @height = w, h
   end

   # accessor methods
   def getWidth
      @width
   end
   def getHeight
      @height
   end

   # setter methods
   def setWidth=(value)
      @width = value
   end
   def setHeight=(value)
      @height = value
   end
end

# create an object
box = Box.new(10, 20)

# let us freez this object
box.freeze
if( box.frozen? )
   puts "Box object is frozen object"
else
   puts "Box object is normal object"
end

# now try using setter methods
box.setWidth = 30
box.setHeight = 50

# use accessor methods
x = box.getWidth()
y = box.getHeight()

puts "Width of the box is : #{x}"
puts "Height of the box is : #{y}"
# Box object is frozen object
# test.rb:20:in `setWidth=': can't modify frozen object (TypeError)
#    from test.rb:39
```

## Class Constants ##

If you want to access a class constant you need to use **classname::constant**

```ruby
# define a class
class Box
   BOX_COMPANY = "TATA Inc"
   BOXWEIGHT = 10
   # constructor method
   def initialize(w,h)
      @width, @height = w, h
   end
   # instance method
   def getArea
      @width * @height
   end
end

# create an object
box = Box.new(10, 20)

# call instance methods
a = box.getArea()
puts "Area of the box is : #{a}"
puts Box::BOX_COMPANY
puts "Box weight is: #{Box::BOXWEIGHT}"
# Area of the box is : 200
# TATA Inc
# Box weight is: 10
```

## Create Object Using Allocate ##

If there is ever a situation where you want to create an object without calling its constructor method **initialize** i.e. using a new method, then you would call *allocate*, which will create an uninitialized object

```ruby
# define a class
class Box
   attr_accessor :width, :height

   # constructor method
   def initialize(w,h)
      @width, @height = w, h
   end

   # instance method
   def getArea
      @width * @height
   end
end

# create an object using new
box1 = Box.new(10, 20)

# create another object using allocate
box2 = Box.allocate

# call instance method using box1
a = box1.getArea()
puts "Area of the box is : #{a}"
# => Area of the box is : 200

# call instance method using box2
a = box2.getArea()
puts "Area of the box is : #{a}"
# => test.rb:14: warning: instance variable @width not initialized
# => test.rb:14: warning: instance variable @height not initialized
# => test.rb:14:in `getArea': undefined method `*' 
  #  for nil:NilClass (NoMethodError) from test.rb:29
```

## Class Information ##

self must reference something

```ruby
class Box
   # print class information
   puts "Type of self = #{self.type}"
   puts "Name of self = #{self.name}"
end

# => Type of self = Class
# => Name of self = Box
```