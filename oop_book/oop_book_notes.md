# OOP Book Notes

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

### Instance Methods ###

### Accessor Methods ###

### Exercises 2 ###

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