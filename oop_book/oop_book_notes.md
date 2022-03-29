# OOP Book Notes #

- [The Object Model](#the-object-model)
  - [Classes Define Objects](#classes-define-objects)
  - [Modules](#modules)
  - [Method Lookup](#method-lookup)
  - [Exercises](#exercises-1)
- [Classes and Objects - Part I](#classes-and-objects-i)
  - [States and Behaviors](#states-and-behaviors)
  - [Initializing a New Object](#initializing-a-new-object)
  - [Instance Variables](#instance-variables)
  - [Instance Methods](#instance-methods)
  - [Accessor Methods](#accessor-methods)
  - [Exercises](#exercises-2)
- [Classes and Objects - Part II](#classes-and-objects-ii)
  - [Class Methods](#class-methods)
  - [Class Variables](#class-variables)
  - [Constants](#constants)
  - [The to_s Method](#the-tos-method)
  - [More About self](#more-about-self)
  - [Exercises](#exercises-3)
- [Inheritance](#inheritance)
  - [Class Inheritance](#class-inheritance)
  - [super](#super)
  - [Mixing in Modules](#mixing-in-modules)
  - [Inheritance vs Modules](#inheritance-vs-modules)
  - [Method Lookup Path](#method-lookup-path)
  - [More Modules](#more-modules)
  - [Private, Protected, and Public](#private-protected-and-public)
  - [Accidental Method Overriding](#accidental-method-overriding)
  - [Exercises](#exercises-4)



## The Object Model ##

### Classes Define Objects ###

*classes*
: the attributes and behaviors of its objects

Classes are basic outlinbes of what an object should be made of and what it should be able to do.

Defining a class has syntax similar to defining a method. We replace the `def` with `class` and use the CamelCase naming convention to create the name. We then use the reserved word `end` to finish the definition. Ruby file names should be `snake_case`, and reflect the class name.

```ruby
# good_dog.rb
class GoodDog
end

sparky = GoodDog.new
```
In the above example, we created an instance of our `GoodDog` class and stored it in the variable `sparky`. We cna now say that `sparky` is an object or instance of class `GoodDog`. This entire workflow of creating a new object or instance from a class is called **instantiation**, so we can also say that we've instantiated an object called `sparky` from the class `GoodDog`

A visual for what we're doing...
![Class Inheritance Diagram](./images/class_instance_diagram.jpg)

### Modules ###

Modules are another way to achieve polymorphism in Ruby.

*module*
: a collection of behaviors that are usable in other classes via **mixins**

A module is "mixed in" to a class using the `include` method invocation. If we wanted `GoodDog` to have a `speak` method but also other classes could use the speak method as well, here's what we would do...

```ruby
#good_dog.rb
module Speak
  def speak(sound)
    puts sound
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

sparky = GoodDog.new
sparky.speak("Arf!")   # => Arf!
bob = HumanBeing.new
bob.speak("Hello!")    # => Hello!
```

Both the `GoodDog` object and `HumanBeing` object both have access to the `speak` instance method through "mixing in" the module `Speak`. It's as if we copy-pasted the `speak` method into the `GoodDog` and `HumanBeing` classes.

### Method Lookup ###

Ruby has a distinct loopup path that it follows each time a method is called. If we use the program from above to see what the method lookup path is for our `GoodDog` class, we can use the `ancestors` method on any class to find out that method lookup chain.

```ruby
#good_dog.rb
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

puts "---GoodDog ancestors---"
puts GoodDog.ancestors
puts ''
puts "HumanBeing ancestors---"
puts HumanBeing.ancestors
```

Output of the above code would be...

```ruby
---GoodDog ancestors---
GoodDog
Speak
Object
Kernel
BasicObject

---HumanBeing ancestors---
HumanBeing
Speak
Object
Kernel
BasicObject
```

The `Speak` module is right between out custom classes and the `Object` class that comes with Ruby.

This means that since the `speak` method is not defined in the `GoodDog` class, the next place it looks is in the `Speak` module. This conintues in an ordered, linear fashion, until the method is either found, or there aren't any more places to look.

### Exercises 1 ###

1. How do we create an object in Ruby? Give an example of the creation of an object.

> We create an object by defining a class and instantiating it by using the `.new` method to create an instance, also known as an object.

```ruby
class Creation
end

the_world = Creation.new
```

2. What is a module? What is its purpose? How do we use them with our classes? Create a module for the clsas you created in exercise 1 and include it properly

> A module is a collection of behaviors that are usable in other classes via **mixins**. It allows us to use behaviors that can be used by multiple differenct classes. Any class could have access to the trees instance method if they mixed-in Foliage through the `include` method within their class definition

```ruby
module Foliage
  def trees
    puts "We planted a tree!"
  end
end

class Creation
  include Foliage
end

the_world = Creation.new
the_world.trees
```

## Classes and Objects I ## 

### States and Behaviors ###

We use classes to create objects. When defining a class, we typically focus on two things: *states* and *behaviors*.

*states*
:track attributes for individual objects

*behaviors*
:exactly what objects are capable of doing

Instance variable keep track of state, and instance methods expose behavior for objects.

### Initiailizing a New Object ###

Using the `GoodDog` class from before, let's add an `initialize` method that will be called everytime a new object is created from the `GoodDog` class.

```ruby
class GoodDog
  def initialize
    puts "This object was initialized!"
  end
end

sparky = GoodDog.new      # => "This object was initialized!"
```

We call the `new` method when we create an object, and that eventually leads us to the `initialize` method. In this example above, initializating a new `GoodDog` object triggered the `initialize` method and resulted from the string being outputted. We refer to the `initialize` method as a *constructor*, because it gets triggered whenever we create a new object.

### Instance Variables ###

Let's now create a new object and instantiate it with some state, like a name.

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
end
```

We have just used an **instance variable** for `@name`

**instance variable**
: a variable that exists as long as the object instance exists. It is one of the ways we tie data to objects.

It does does not "die" after the initialize method is run, but rather it "lives on", to be referenced, until the object instance is destroyed.

In the example above, our `initialize` method take a parameter called `name`. You can pass arguments into the `initialize` method throgh the `new` method.

```ruby
sparky = GoodDog.new("Sparky")
```

Here, the string "Sparky" is being passed from the `new` method through the `initialize` method and is assigned to the local variable `name`. Within the constructor (i.e., the `initialize` method), we then set teh instance variable `@name` to `name`, which results in assigning the string "Sparky" to the `@name` instance variable.

Instance variable are responsible for keeping track of information about the *state* of an object. Above, the name of the `sparky` object is the string "Sparky". This state for the object is tracked in the instance variable, `@name`. We could create another `GoodDog` object with `fido = GoodDog.new('Fido')`, then the `@name` instance variable for the fido object would contain the string "Fido"

Every object's state is unique, and instance variables are how we keep track.

### Instance Methods ###

```ruby 
class GoodDog
  def initialize(name)
    @name = name
  end
  
  def speak
    "Arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak           # => Arf!

fido = GoodDog.new("Fido")
puts fido.speak             # => Arf!
```

Each of these objects perform the same `GoodDog` behaviors. All objects of the same class have the same behaviors, though they contain different states; here, the differing state is the name.

If we wanted to say "Sparky says arf!", then in our instance method(which are what all methods are so far), we have to access our instance variable. We can use string interpolation to accomplish this...

```ruby
def speak
  "#{@name} says arf!"
end

puts sparky.speak           # => "Sparky says arf!"
puts fido.speak             # => "Fido says arf!"
```

### Accessor Methods ###

If we wanted to access the name of an object, we would need to create a method that will return the name, which is stored in the `@name` instance variable

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts spark.get_name

# Output =>
# Sparky says arf!
# Sparky
```

This demonstates a *getter* method. If we wanted to change `sparky's` name, we would need a *setter* method.

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

  def set_name=(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.get_name
sparky.set_name = "Spartacus"
puts sparky.get_name

# Output
# Sparky says arf!
# Sparky
# Spartacus
```

*setter* method `set_name=` above is special syntax from Ruby.

To use the `set_name=` method normally, we would actuall write `sparky.set_name=("Spartacus")`, where the entire "set_name=" is the method name, and the string "Spartacus" is the argument being passed in to the method. Ruby recognizes that this is a *setter* method and allows us to sue the more natural syntax of `sparky.set_name = "Spartacus"`. This is more of Ruby's syntactical sugar.

Typically, Rubyists want to name the *getter* and *setter* methods with the same name as the instance variable they are exposing and setting.

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def name                  # This was renamed from "get_name"
    @name
  end

  def name=(n)              # This was renamed from "set_name="
    @name = n
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"
```

*Setter* methods will always return the value that is passed in as an argument, regardless of what happens inside of the method. It'll just ignore the code.

```ruby 
class Dog
  def name=(n)
    @name = n   
    "Laddieboy"   ##<= value will be ignored
  end
end

sparky = Dog.new()
puts(sparky.name = "Sparky")   # returns "Sparky"
```

That code is pretty long and if we wanted to also track height or weight, it would be even longer. Ruby has a built-in way to automatically create these *setter* and *getter* methods using the **att_accessor** method.

```ruby
class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"
```

The `attr_accessor` method takes a symbol as an argument, which it uses to create the method name for the `getter` and `setter` methods. This one line replaced two method definitions.

If you want the `getter` method only, use `attr_reader`. This works the same way but only allows you to retrieve the instance variable.

If you only want the `setter` method, use the `attr_writer` method.

All of the `attr_*` methods take a `Symbol` as parameters, and if you wanted to track more states, use:

```ruby
attr_accessor :name, :height, :weight
```

#### Accessor Methods in Action ####

```ruby
def speak
  "#{@name} says arf!"
end
```

Instead of using the instance variable `@name`, we can use the getter method like below.

```ruby
def speak
  "#{name} says arf!"
end
```

This now calls the instance method instead of the instance variable. Why make this change? It's generally a good idea to call the *getter* method instead of referencing the instance variable.

Suppose we're keeping track of social security numbers in an instance variable called @ssn. And suppose that we don't want to expose the raw data, i.e. the entire social security number, in our application. Whenever we retrieve it, we want to only display the last 4 digits and mask the rest, like this: "xxx-xx-1234". If we were referencing the @ssn instance variable directly, we'd need to sprinkle our entire class with code like this:

```ruby
# converts '123-45-6789' to 'xxx-xx-6789'
'xxx-xx-' + @ssn.split('-').last
```

But if we wanted to change the format or if there's a bug, t's much easier to just reference a getter method and make changes in one place.

```ruby
def ssn
  #converts '123-45-6789' to xxx-xx-6789'
  'xxx-xx-' + @ssn.split('-').last
end
```

Now we can use the `ssn` instance method throughout our class to retrieve the social security number.

If we added two more states to track to the `GoodDog` class called "height" and "weight":
```ruby
attr_accessor :name, :height, :weight
```
This one line of code gives us six getter/setter instance methods: `name`, `name=`, `height`, `height=`, `weight`, `weight=`. It also gives us three instance variables: `@name`, `@height`, and `@weight`. Now we can create a new method that allows us to change several states at once called `change_info(n, h, w)`. Implemented below

```ruby
def change_info(n, h, w)
  @name = n
  @height = h
  @weight = w
end
```

To get caught up with out `GoodDog` class

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} say arf!"
  end

  def change_info(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end
```

Use the `change_info` method like this:
```ruby
sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      # => Spartacus weighs 45 lbs and is 24 inches tall.
```

Just like when we replaced accessing the instance variable directly, we'd want to do the same with out setter method.

```ruby
def change_info(n, h, w)
  name = n
  height = h
  weight = w
end
```

This didn't change sparky's information though...

#### Calling Methods With self ####

Ruby thought we were initializing local variables. It turns out that instead of calling the setter methods `name=`, `weight=`, or `height=`, we actually created three new local variables, which isn't what we wanted.

To disambiguate from creating a local variable, we need to use `self.name=` to let Ruby know that we're calling a method. `change_info should be updated to 
```ruby
def change_info(n, h, w)
  self.name = n
  self.height = h
  self.weight = w
end
```
This tells Ruby that we're calling a setter method, not creating a local variable. For consistency, adopt this syntax for the getter methods as well
```ruby
def info
  "#{self.name} weighs #{self.weight} and is #{self.height} tall."
end
```

> Note that prefixing `self`. is not restricted to just the accessor methods; you can use it with any instance method. For example, the `info` method is not a method given to us by `attr_accessor`, but we can still call it using `self.info`:

```ruby
class GoodDog
  # ... rest of code omitted for brevity
  def some_method
    self.info
  end
end
```

### Exercises 2 ###

```ruby
=begin
1. 
  - Create a class called MyCar. 
  - When you initialize a new instance or object of the class, allow the user 
  to define some instance variables that tell us the year, color, and model of the car. 
  - Create an instance variable that is set to 0 during instantiation of the  
  object to track the current speed of the car as well. 
  - Create instance methods that allow the car to speed up, brake, and shut the car off.
2.
  - Add an accessor method to your MyCar class to change and view the color of your car. 
  - Add an accessor method that allows you to view, but not modify, the year of your car.
3.
  - Create a method called spray_paint that can be called on an object and will 
  modify the color of the car.
=end

class MyCar
  attr_accessor :color, :model, :current_speed
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c 
    @model = m 
    @current_speed = 0
  end

  def spray_paint(color)
    self.color = color
    "Your new #{color} paint job looks great!"
  end

  def info
    "Your car is a #{self.color} #{self.year} #{self.model}"
  end

  def speed_up(mph)
    self.current_speed += mph
    "You accelerate #{mph} mph."
  end

  def brake(mph)
    self.current_speed -= mph
    "You brake and decelerate #{mph} mph."
  end

  def turn_off
    self.current_speed = 0
    "You have just turned off your car."
  end

  def current
    "You are now going #{self.current_speed} mph"
  end
end

armada = MyCar.new(2019, 'Silver', 'Nissan Armada')

puts '---ex 1---'
puts armada.speed_up(75)
puts armada.current
puts armada.speed_up(10)
puts armada.current
puts armada.brake(55)
puts armada.current
puts armada.brake(20)
puts armada.current
puts armada.turn_off
puts armada.current
puts '---ex2---'
puts armada.info
puts armada.spray_paint('Black')
puts armada.info

# Output
# ---ex 1---
# You accelerate 75 mph.
# You are now going 75 mph
# You accelerate 10 mph.
# You are now going 85 mph
# You brake and decelerate 55 mph.
# You are now going 30 mph
# You brake and decelerate 20 mph.
# You are now going 10 mph
# You have just turned off your car.
# You are now going 0 mph
# ---ex2---
# Your car is a Silver 2019 Nissan Armada
# Your new Black paint job looks great!
# Your car is a Black 2019 Nissan Armada
```

## Classes and Objects II ## 

### Class Methods ###



### Class Variables ###

### Constants ###

### The to_s Method ###

### More About self ###

### Exercises 3 ###

## Inheritance ##

### Class Inheritance ###

### super ###

### Mixing in Modules ###

### Inheritance vs Modules ###

### Method Lookup Path ###

### More Modules ###

### Private, Protected, and Public ###

### Accidental Method Overriding ###

### Exercises 4