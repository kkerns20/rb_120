# Polymorphism and Encapsulation #

## Polymorphism ##

**Polymorphism**
: the ability for objects of a different types to respond in different ways to the same method calls (or other messaging). Put another way, polymorphism is how various objects of different classes have different functionality (aka implementation), but these same objects/classes share a *common interface*.

Polymorphism happens when we can call a method without caring about the type of a calling object. Basically, when two or more different object types have a method of the same name, we can invoke that method on any of the objects. The results may be the same, or the results may be more specific to that particular object type, but the *message* we use (the method call) to invoke the behavior is the same, which is the essence of polymorphism.

```ruby
# we can perform arithmetic operations seamlessly on either floats or integers
puts 1 + 1      # => 2
puts 1.2 + 1.2  # => 2.4
puts 1 + 1.2    # => 2.2

# integer division and float division can be called the same way
puts 7 / 2      # => 3
puts 7.0 / 2.0  # => 3.5

# we can create different objects by calling the same method (here with ::new)
Hash.new        # => {}
Array.new       # => []
String.new      # => ''

# we can learn things about various objects using the same method call
"let's go".class    # => String
2020.class          # => Integer
['a', 'b', 'c']     # => Array

# the same method call knows how to work with different data structures
[1, 2, 3, 4].each { |num| puts num }
  # => 1
  # => 2
  # => 3
  # => 4

{one: 1, two: 2, three: 3, four: 4}.each { |word, num| puts "#{word} #{num}"}
  # => one 1
  # => two 2
  # => three 3
  # => four 4
```

***client code***
: the method we invoke with various objects, which only cares that that calling object has a corresponding method that is invoked the same way (i.e. with or without arguments, with or without a block).

Polymorphism can be implemented through both [inheritance](./inheritance.md) or [duck typing](#polymorphism-through-duck-typing).

### Polymorphism through Inheritance ###

Polymorphism through inheritance works in two ways:

  1. A specific instance of a subclass inherits a more generic method implementation from a superclass.

  2. A subclass overrides a more generic method implementation from a superclass with a different, more specific behavior by implementing a method of the same name.

```ruby
class Animal
  def eats
    puts "feeds on living things"
  end
end

class Carnivore < Animal
  def eats
    puts "feeds on meat"
  end
end

class Herbivore < Animal
  def eats
    puts "feeds on plants"
  end
end

class Omnivore < Animal; end

lion = Carnivore.new
rabbit = Herbivore.new
person = Omnivore.new

animals = [lion, rabbit, person]
animals.each { |animal| animal.eats }
# => feeds on meat
# => feeds on plants
# => feeds on living things
```

In the code above, we define a more general `eats` method in the superclass `Animal` that is availbale to all `Animal` obje3cts. In the `Carnivore`subclass, we override this method to implement a process that's more specific to the `Carnivore` type. Similarly, in the `Herbivore` subclsas, we override `Animal#eats` for a more specific implementation; however, in the `Omnivore` subclass, no more specific implementation is needed, so we allow it to inherit the generic impletmentation from `Animal`.

Because we have defined more specific types of `eats`, we can work with all the different types of objects in the same way, even though the implementations may be different. This is shown when we create three objects, `lion` from the `Carnivore` class, `rabbit` from the `Herbivore` class, and `person` from the `Omnivore` class, and we place them in an array. We are able to iterate over eeach object in the array and invoke the `eats` method on all of them despite the fact that they are all object of a different type.

This example is the essence of accessing *different implementations* through a *common interface* (in this case, the *client code* `eats`). When we call `eats` on `lion`, the `Carnivore#eats` method is invoked, and we see the appropriate output `'feed on meat'`. When we call `eats` on the `rabbit`, the `Herbivore#eats` method is invoked and again we see the appropriate output `'feeds on plants'`. Finally,  we invoke `eats` on `person` and the inherited `Animal#eats` method is called, which gives us the more generic output of `'feeds on other living things'`.

The above code works because the block `animal.eats` only really cares that each element in teh array has an `eats` method that is called with no arguments, which is the case here. The *interface* (`eats`) is the same for all the objects, despite their different *implementations*.

Polymorphism can also be exhibited when **mixing in a module**. When we mix a module into a class using `include`, all the behaviors declared in the module are available to the class and its objects. This is know as [inteface inheritance](./inheritance.md#interface-inheritance). Two distinct class that include the same module can also be said to exhibit polymorphism, as both instances can access the same interface (defined by the module).

```ruby
module Swimmable
  def swim
    "I'm swimming"
  end
end

class Dog
  include Swimmable
end

class Fish
  include Swimmable
end

class Cat; end

kirra = Dog.new
garfield = Cat.new
nemo = Fish.new

# both the Dog and Fish object can access the included `
`swim` method (polymorphism)
fido.swim       # => I'm swimming
nemo.swim       # => I'm swimming

# but the Cat object cannot (It is not included)
garfield.swim   # => NoMethodError
```

b
