# All of the material below is everything covered in OOP Book from LS

# define a class
class Box
  # Initialize our class variables
  @@count = 0
  # constructor method
  def initialize(w,h)
     @width, @height = w, h

     @@count += 1
  end

  # define to_s method
  def to_s
    "(w:#@width,h:#@height)"  # string formatting of the object.
 end

  # accessor methods
  def getWidth
     @width
  end

  def getHeight
     @height
  end

  # instance method
  def getArea
    @width * @height
 end

  # setter methods
  def setWidth=(value)
     @width = value
  end

  def setHeight=(value)
     @height = value
  end

  def self.printCount()
    puts "Box count is : #@@count"
 end
end

# define a subclass
class BigBox < Box

  # change existing getArea method as follows
  def getArea
     @area = @width * @height
     puts "Big box area is : #@area"
  end
end

# create an object
box1 = Box.new(10, 20)
box2 = Box.new(30, 100)

# use setter methods
box1.setWidth = 30
box1.setHeight = 50

# use accessor methods
x = box1.getWidth()
y = box1.getHeight()

puts "Width of the box1 is : #{x}"
puts "Height of the box1 is : #{y}"
# Width of the box is : 30
# Height of the box is : 50

# call instance methods
a = box1.getArea()
puts "Area of the box1 is : #{a}"
# Area of the box is : 200

# call class method to print box count
Box.printCount()
# Box count is : 2

# to_s method will be called in reference of string automatically.
puts "String representation of box1 is : #{box1}"
# String representation of box is : (w:10,h:20)

# create an object
box = BigBox.new(10, 20)

# print the area using overriden method.
box.getArea()