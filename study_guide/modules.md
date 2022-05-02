# Modules #

A **module** is a special type of container used in [interface inheritance](./inheritance.md#interface-inheritance). Modules are generally used to store behaviors we want available in some, but not all, subclasses. It is a way to avoid repeating certain code logic that doesn't make sense to pass along in a formal hierarchy as with class inheritance.

A module *cannot instantiate an objedt*. Only a class can have an instance. Therefore, modules are obnly used for **namespacing** and **grouping common methods together**.

## Mixin Modules ##

Ruby exhibits *single inheritance*, that is, a class can only directly subclass from one superclass. Because of this, sometimes there are methods we need defined that don't really fit into our formal class inheritance structure. The answer to this is the *misin module*. Though a subclass can only inherit from a single parent, it can mix in as many modules as it likes.

```ruby
module Speakable
  def speak(sound)
    puts sound
  end
end

class Animal
  def eats
    puts "eats food"
  end
end

class Fish < Animal; end

class Person < Animal
  include Speakable
end

class Cat < Animal
  include Speakable
end

felix = Cat.new
bob = Person.new
nemo = Fish.new

# all objects have access to Animal#eats through class inheritance
felix.eats          # => "eats food"
bob.eats            # => "eats food"
nemo.eats           # => "eats food"

# not all animals speak, but some do, so we mixin a module
felix.speak('meow') # => "meow"
bob.speak('hello')  # => "hello"
nemo.speak('glub')  # => NoMethodError: undefined method `speak'
```

In the above code example, we have the superclass `Animal` with the instance method `eats` defined within, because all animals eat. We then have the subclasses `Person`, `Cat`, and `Fish`. Not all of these animals have the capacity to "speak", so it would not be appropriate to put a `#speak` method into the `Animal` class.

We avoid having to define `#speak` twice in both `PErson` and `Cat` by extracting the repeated logic to the `Speakable` module and mixing it in. Using the `include` keyword here allows out `Person` and `Cat` class to inherit all the methods defined within `Speakable` via [interface inheritance](./inheritance.md#interface-inheritance).

> When should we use a mixin module?

-Ask what the relationship is:

- If there's an **is-a** relationship (as in "A Cat is an Animal") then we use class inheritance.
- If there's a **has-a** relationship (as in "A Person has the ability to speak") then we use a mixin module.
- Use mixin modules to group methods together that multiple unrelated classes will have to access.
- Do not use a module for anything that needs to be instantiated.
