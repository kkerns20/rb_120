# Accessor Methods #

- [Getter Methods](#getter-methods)
- [Setter Methods](#setter-methods)
- [attr_*](#using-attr)

## What are setters and getters? ##

**Accessor Methods**
: special methods used with [instance variables](./classes_object.md) that allow us to *get* or *set* the data contained within the state of an object.

## Getter Methods ##

Outside of the class, we need a specifically defined method to access the values stored within the instance variables associated with an object. We can define this method within the class so that when we retrieve the value in question wherever the object is accessible.

```ruby
# This will not work properly
class Superhero
  def initialize(name)
    @name = name
  end
end

wolverine = Superhero.new('Logan')
wolverine.name
# => NoMethodError: undefined method 'name'

# This will work
class Superhero
  def initialize(name)
    @name = name
  end

  def name
    @name     # technically, we can call this method anything
  end
end

wolverine = Superhero.new('Logan')
wolverine.name
# => 'Logan'
```

In the code above, we define the `Superhero` class such that an instance of `Superhero` contains the attribute `@name`. In the first example, there is no getter method defined, so when we call `wolverine.name` on our `Superhero` object, we get a `NoMethodError`.

The second example defines the instance method `#name` which returns the value referenced by the instance variable `@name`. We can call this method anythign we want (`show_name`, `get_name`, etc...), but by convention it's best to use the name of the instance variable you want to return.

This method returns the value associated with `@name` for the individual object that calls it. In this case, that's the string `'Logan'`, which is returned by the invocation `wolverine.name`.

Getter methods like these can also be used within the class. In fact, it's better to access the value of an instance variable through a getter method than using the instance variable directly. This makes for more flexible and easy to maintain code (because changes need only be made where the getter method is defined).

When using the getter methods within the class, simply drop the `@` at the begining of the instance variable (this is why we call getter methods by the same name as the attribute). Calling a method without an explicit caller causes Ruby to set the default caller to `self`. As long as you are scoped at the object level(i.e. within an instance method), this will refer to the object, meaning we can call the getter method name on its own.

```ruby
class Superhero
  def initialize(n)
    @name = n         # intialize @name
  end

  def name
    @name             # define getter method #name
  end

  def introduce       # access @name through getter method #name
    puts "Sup? It's your friendly neighborhood #{name}!"
  end
end

spider_man = Superhero.new("Spider-Man")
spider_man.name             # => Spider-Man
spider_man.introduce        # => Sup? It's your friendly, neighborhood Spider-Man!
```

## Setter Methods ##

Setter methods allow us to initialize and reassign attributes for a particular object, i.e. change the data stored within an instance variable. They are defined similarly to getter methods, but they include *reassignment* within the method definition. Because of this, we name them with the `=` after the method name, which disambiguates them from our getter methods, as well as allows us to take advantage of Ruby's *syntactical sugar*.

```ruby
class Superhero
  def initialize(n)
    @name = n         # intialize @name
  end

  def name
    @name             # define getter method #name
  end

  def name=(n)
    @name = n         # define setter method #name=
  end

  def introduce       # access @name through getter method #name
    puts "Sup? It's your friendly neighborhood #{name}!"
  end
end

spider_man = Superhero.new("Spider-Man")
spider_man.name             # => Spider-Man
spider_man.introduce        # => Sup? It's your friendly, neighborhood Spider-Man!

# call #name=() with Ruby's syntactical sugar
spider_man.name = 'Peter Parker'
spider_man.introduce        # => Sup? It's your friendly, neighborhood Peter Parker!
```

Setter methods, like getter methods, can be called from within the class; however, because they use the syntax of `#method_name = argument`, we must distinguish them somehow from local variable initiailization. To do this, we call them with the keyword `self`.

```ruby
# this will not work
class Contact
  attr_accessor :name, :number

  def initialize(name, number)
    @name = name
    @number = number
  end

  def change_number(n)
    number = n                  # Ruby thinks we are initializing local variable
  end
end

kurt = Contact.new('Kurt', '234-2107')
kurt.number                    # => 234-2107

kurt.change_number('867-5309')
kurt.number                    # => 234-2107

# this will work
class Contact
  attr_accessor :name, :number

  def initialize(name, number)
    @name = name
    @number = number
  end

  def change_number(n)
    self.number = n                  # call setter method using self.
  end
end

kurt = Contact.new('Kurt', '234-2107')
p kurt.number                    # => 234-2107

kurt.change_number('789-4039')
p kurt.number                    # => 789-4039
```

## Using attr_* ##

Because setter and getter methods are so commonplace, Ruby gives us a built-in shorthand to create them: `attr_accessor`. This method takes a *symbol* as an argument, which is used to create the method name for *both* the getter and the setter methods. This is nice because we can now replace long and cumbersome method definitions with a single line.

```ruby
class Student
  attr_accessor :name, :grade, :age

  def initialize(n, a)
    @name = n
    @age = a
    @grade = 'A'
  end

  def show_information
    puts "Name: #{name}"      # we use getter method to access instance variables
    puts "Age: #{age}"
    puts "Grade: #{grade}"
  end
end

scream = Student.new('Scream', 19)
doofy = Student.new('Doofy', 25)

scream.show_information
# => Name: Scream
# => Age: 19
# => Grade: A

doofy.show_information
# => Name: Doofy
# => Age: 25
# => Grade: A

doofy.grade = 'F'             # use setter method to change instance variable
doofy.show_information
# => Name: Goofus
# => Age: 25
# => Grade: F
```

If you have attributes that you do not want modified from outside the class, you can create a getter method without a setter method for them by using the shorthand `attr_reader`.

Further, if you want to be able to modify an attribute without necessarily being able to view it outside the class (such as for sensitive information like a social security number or password), you can create a setter without a getter using the `attr_writer` shorthand.

```ruby
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
```
