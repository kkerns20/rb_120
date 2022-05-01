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


  ```
