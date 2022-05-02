# Method Access Control #

**Method access control**
: implemented through the use of *access modifiers* that restrict access to methods within a class. In Ruby, this is accomplished with the `public`, `private`, and `protected` access modifiers.

## Public ##

A public method is one that is available to anyone who knows either the class or object name. It is readily available for use throughout the program, whether inside or outside of the class.

A class's **interface** consists only of it's public methods. This describes how other classes and objects interact with this clasds and its instances.

```ruby
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
```

## Private ##

Private methods are those that work *within the class* but are not available in the rest of the program. They are *only* accessible from other methods within the class.

Private methods are defined with the `private` method call within a class. Anything that comes after the invocation of `private` will be considered a private method.

```ruby
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
```

In the code above, we define the `Person` class such that the setter and getter methods for `@name` are private. We also provide the public instance method `#introduce` as the interface for being able to access the value stored in `@name` outside the class.

When we initialize a new `Person` object, `bruce`, we can only access the value stored within `@name` through teh `#introduce` method. Any call to the `name`getter outside the class wiill result in a `NoMethodError`. We are still able to invoke the `name`getter method within the class, however, as can be seen in the implementation of the `#introduce` method.

## Protected ##

Protected methods are those that are available within the *class* as opposed to only being available within an *instance of the class*. For practical purposed, this means that they can be invoked by all objects within a certain class, but only from within the class.

This differs from `private` methods in that a private method can only be called by the singular instance within the class. We can use `protected` methods to compare object of a particular class, which is their most common use.

```ruby
# this will not work
class Student
  attr_reader :name

  def initialize(name, id)
    @name = name
    @id = id
  end

  def ==(other_student)
    id == other_student.id  # #id is private so cannot be called by another instance 
  end

  private
  attr_reader :id
end

wit = Student.new('Wit', 12345)
rhone = Student.new('Rhone', 23414)
wit == rhone                        # => NoMethodError: # #id is private so cannot be called by another instance 

# this will work
class Student
  attr_reader :name

  def initialize(name, id)
    @name = name
    @id = id
  end

  def ==(other_student)
    id == other_student.id  # #id is private so cannot be called by another instance 
  end

  protected
  attr_reader :id
end

wit = Student.new('Wit', 12345)
rhone = Student.new('Rhone', 23414)
wit == rhone                        # false
wit = wit                           # true
```
