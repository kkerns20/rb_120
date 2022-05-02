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

### Polymorphism through Duck Typing ###

**Duck Typing**
: when different unrelated types of objects both respond ot the same method name. Here, we want to see that an object has a *particular behavior* rather that if it is a ceratin class/type. Polymorphism through duck typing means that idfferent ytpes of object can have idfferent methods of various implementations, all with the same interface (name + arguments), despite not inheriting these methods.

We can tell when duck typing is in play because it deals with a number of objects that share a common interface, even though they have no relationship via class or module. Duck typing focuses on what an object can *do* rather that what an object *is*.

This of a webpage, which has an assortment of unrelated clickable elements. A link, a button, a checkbox, an image, or a text input field. All these things might have a method that defines the various implementation for each when clicked by the mouse. However, they are not formally *types* thogether as they might be through class inheritance. They simple all exhibit the same behavior.

#### Example 1 (from LS material) ####

```ruby
class Wedding
  attr_reader :guests, :flowers, :songs

  def initialize(guests, flowers, songs)
    @guests = guests
    @flowers = flowers
    @songs = songs
  end

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    guests.each { |guest| puts "Dinner for #{guest}" }
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_venue(wedding.flowers)
  end

  def decorate_venue(flowers)
    puts "Some #{flowers} here, there, and everywhere!"
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    songs.each { |song| puts "I'm gonna rock #{song}" }
  end
end

wedding = Wedding.new(['bride', 'groom'], 'lillies', ["Can't help falling in love"])

wedding.prepare([Chef.new, Decorator.new, Musician.new])
# => Dinner for bride
# => Dinner for groom
# => Some lillies here, there, and everywhere!
# => I'm gonna rock Can't help falling in love
```

The code above exhibits polymorphism through duck typing. Although there is no inheritance, we have a selection of *preparer type* classes (`Chef`, `Decortator`, and `Musician`) which all provide a `prepare_wedding` method that takes one argument. Since each different object responds to the same method call, we can say this is polymorphism.

First, we define our `Wedding` class with instance vairables such that we can pass along the specific data that each preparer type object needs to implement their version of `prepare_wedding`. We pass the `Wedding#prepare` instance method one argument, an array of these duck typed "preparer" objects. Within `Wedding#prepare`, we invoke `prepare_wedding` on each preparer object and pass it the calling `Wedding` object (represented by `self`) as an argument.

When defining each "preparer" type class, we implement a `prepare_wedding` method that takes one argument (presumably a `Wedding` object). Within this method, we call a different instance method that executes the specific impletmentation for that particular preparer-type object. For example, the `Chef#prepare_wedding` method invokes the `Chef#prepare_food` method.

Further, when we invoke the specific implementation for that particular preparer_type object, we use a `Wedding` instance variable getter method to get the specific data required for the specific implementation. The `Chef#prepare_food` instance method accesses the `@guests` `Wedding` attribute, the `Decorator#decorate_venue` instance method access the `@flowers` `Wedding` attribute, etc.

This ensures that we will have the appropriate implementation for each distinct preparer-type object despite the fact that they all share the same interface, `prepare_wedding(wedding)`. This is shown when we call `prepare` on a `Wedding` instance, which outputs the result of each preparer-type's `prepare_wedding` implementation as we'd expect.

#### Example 2 ####

```ruby
class BasketballGame
  def play(attendees)
    attendees.each do |attendee|
      attendee.participate
    end
  end
end

class Player
  def participate
    play_game
  end

  def play_game
    puts "He shoots, he rebounds, he SCORES!!"
  end
end

class Coach
  def participate
    coach_players
  end

  def coach_players
    puts "Get your hands up and BOX OUT!"
  end
end

class Referee
  def participate
    make_calls
  end

  def make_calls
    puts "<whistle!> Over the back on number 23!"
  end
end

class Cheerleader
  def participate
    cheer_on_team
  end

  def cheer_on_team
    puts "Let's go Bobcats!"
  end
end

the_game = BasketballGame.new

the_game.play([Player.new, Coach.new, Referee.new, Cheerleader.new])
# => He shoots, he rebounds, he SCORES!!
# => Get your hands up and BOX OUT!
# => <whistle!> Over the back on number 23!
# => Let's go Bobcats!
```

The above example also shows polymorphism through duck typing. The various classes have no inheritance (either through class or interface) and yet we can see a distrinct "participant" type that all exhibit the behavior `participate`, which takes one argument.

## Encapsulation ##

**Encapsulation**
: describes how we can separate and hide away different pieces of functionality, making them unavailable to the rest of the code base. It is essenetially a form of *data protection* that defines boundaries within a given application.

In Ruby, encapsulation is achieved through creating objects and exposing certain methods to interact with them. That is, Ruby allows us to create objects that separate out the *interface* (methods you call on them) from the *implementation* (what code the methods actually execute). This allows us as programmers to think on a new level of abstraction.

We know that *almost* everything in Ruby is an object. Let's take a built in object type, like `String`, for example. We know that the `reverse` method will return a new string with the order of characters reversed. We know that the `upcase` method will return a new string of all uppercase characters. We know that these methods achieve these things, but we don't really care about *how* they do the things they do (the implementation). We are interested only in the *interface* (the methods you can call on the object). This is the essence of encapsulation.

```ruby
'hello world'.reverse   # => 'dlrow olleh'
'hello world'.upcase    # => 'HELLO WORLD'
# we don't care about the implementation fo the above methods,
# which are defined in the String class
```

Not only does encapsulation let us hide the internal representation of an object from the outside, we want to make sure we only expose the methods and properties tht users of the object need. [Method access control](./method_access_control.md) is employed to ensure that we expose only these necessary properties and methods through the *public interface* of a class. Anything else that deals only with the *internal implementation* can be hidden as a *private* method.

```ruby
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  def has_a_birthday
    # call private setter method to increment @age within the class
    self.age += 1
  end

  def how_old
    # call private getter method for desired output/protect sensitive info
    puts "I am #{age - 3} years old"
  end

  def introduce
    # call private getter method to format @name correctly
    puts "Hi my name is #{name.capitalize}"
  end

  private

  attr_reader :name
  attr_accessor :age
end

wit = Person.new('Wit', 0)

wit.introduce       # => Hi my name is Wit
wit.has_a_birthday  # increments @age
wit.has_a_birthday  # increments @age
wit.has_a_birthday  # increments @age
wit.has_a_birthday  # increments @age
wit.how_old         # => I am 1 years old
```

In the above example, we can call the method `#has_a_birthday` which increments the `@age` of a `Person` object appropriately. The setter `age` is private so that this data is not changed in a way that doesn't make sense for a `Person` object.

Further, we can use the public `introduce` method to ensure that we have the correct formatting for the `@name` attribute. This calls the private getter method `name` and formats the return value in the way we want.

We can protect sensitive information by ensuring that it remains within the class. Here, when we call `how_old` on a `Person` object, it will tell a little while lie that the object in question is slightly younger than in reality. It doesn't matter in the public interface, all we care about is that we are getting data that looks like it pertains to `@age`.

The point of encapsulation is that we get the results we expect from the public interface. As long as this is the case, implementation deetails don't matterand they can stay *encapsulated* within the class.

It's good practice to keep as few methods as possible public. This makes working with a given class much more simple, and protects its data from undesired changes.
