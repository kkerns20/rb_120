# The Object Model #

## Classes Define Objects ##

classes
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
![Class Inheritance Diagram](../images/class_instance_diagram.jpg)

## Modules ##

Modules are another way to achieve polymorphism in Ruby.

module
: a collection of behaviors that is usable in other classes via **mixins**

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

## Method Lookup ##

