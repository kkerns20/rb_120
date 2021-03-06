# Inheritance #

- [Interface Inheritance](#interface-inheritance)
- [Method Lookup Path](#method-lookup-path)
- [Super](#super)
- [Object Methods](#object-methods)
- [Variable Scope with Inheritance](#variable-scope-with-inheritance)
  - [Instance Variables](#instance-variables)
  - [Class Variables](#class-variables)

**Inheritance**
: describes how a class can inherit the behaviors of a superclass, or parent class. This allows us to define basic classes with *large reusability* and smaller *subclasses* for more fine-tuned detailed behaviors.

**Superclass**
: the parent clasws for a subclass. Contains the more common behaviors for a set of subclasses that may share that behavior.

**Subclass**
: the class that inherits from a superclass. In Ruby, all classes are in faact subclasses of the `BasicObject` class.

## Class Inheritance ##

We can use the `<` symbol with a class name to cause a class definition to inherit from any given superclass.

```ruby
class Dog
  def speak
    puts "Ruff!"
  end
end

class Poodle < Dog; end
class Weimaraner < Dog; end
class YorkshireTerrier < Dog; end

# all of the Dog subclasses inherit behavior from the Dog superclass
max = Poodle.new
kirree = Weimaraner.new
albie = YorkshireTerrier.new

max.speak       # => Ruff!
kirree.speak    # => Ruff!
albie.speak     # => Ruff!
```

In the code above, we define a `Dog` superclass with the behavior `#speak`. All subclasses (`Poodle`, `Weimaraner`, `YorkshireTerrier`) inherit this behavior. This makes inheritance an excellent tool for getting rid of duplicate code, giving us a means to extract repeated logic into one place for reuse.

We can define our own custom methods within a subclass to **override** and inherited methods of the same name. Ruby looks for method definitions from the closest possible area on outward; therefore, it will encounter any methods defined in the subclass first and execute the implementation it finds there. If the method name in question is not found, it will continue to look upwards in the chain of superclasses until it find what it is looking for.

```ruby
class Dog
  def speak
    puts "Ruff!"
  end
end

class Poodle < Dog 
  def speak
    puts "Woof!"
  end
end

class Weimaraner < Dog
  def speak
     puts "OowWOOOWWOOOW!"
   end
end

class YorkshireTerrier < Dog
  puts "Yapyapyapyapyap!"
end

class IrishWolfhound < Dog; end

# all of the Dog subclasses inherit behavior from the Dog superclass
max = Poodle.new
kirree = Weimaraner.new
albie = YorkshireTerrier.new
zeus = IrishWolfhound.new

max.speak       # => "Woof!"
kirree.speak    # => "OowWOOOWWOOOW!"
albie.speak     # => "Yapyapyapyapyap!"
zeus.speak      # => "Ruff!"
```

In the code above, we define the `Dog` supercalss with the instance method `#speak` to output `'Ruff'`. Then we define the `Poodle` subclass, which inherits the `#speak` method from `Dog`. However, by defining a new `#speak` method within the class, we can override the `'Ruff!'` output and replace it with `'Woof!'`. Similarly, we override the `#speak` method in the `Weimaraner` and `YorkshireTerrier` subclasses. The `IrishWolfhound` subclass inherits the `#speak` method from `Dog`, and this is not overridden. We see `'Ruff!'` output when it is invoked.

## Interface Inheritance ##

**Interface inheritance**
: describes the inheritance that occurs when we include a *mixin module* with a specific class. This class inherits any behaviors defined in a super class, but *also* inherits the interface provided by the *mixin module*. This does not result in a specialized type, but how thte class can access the methods defined within the module can still be thought of as inheritance.

For more information, see [modules](./modules.md)

## Method Lookup Path ##

The **method lookup path** descirbes the order in which classes are inspected when a method is called to see how that method is defined.

Ruby starts with the nearest method definition (such as the specific subclass) and then moves outward along containers until it finds the method in question. It then executes the code it finds and stops looking. If Ruby never finds the method, it will throw a `NoMethodError` or `NameError`.

We can call the `::ancestors` class method to see the method lookup path for any given class. This returns an array of all the supercalles and modules that have been mixed into the class in which Ruby might search for a method, in order from closest (first searced) to furthest (last searched).

```ruby
class Animal
  def characteristics
    "I am multicellular, obtain energy through consuming food, and have nerve cells, muscles, and/or tissues."
  end
end

module Walkable
  def walk
    "I'm walking"
  end
end

module Swimmable
  def swim
    "I'm swimming"
  end
end

class Person < Animal
  include Walkable
  include Swimmable
end

class Cat < Animal
  include Walkable
end

class Fish < Animal
  include Swimmable
end

Cat.ancestors    # => [Cat, Walkable, Animal, Object, Kernel, BasicObject]
Fish.ancestors   # => [Fish, Swimmable, Animal, Object, Kernel, BasicObject]
Person.ancestors # => [Person, Swimmable, Walkable, Animal, Object, Kernel, BasicObject]
```

In the above code, we can see that Ruby will first check the closest class to the class or object that invokes the method. Next, it will check any modules that are included into that class. If more than one module is included, it will check the *last* included module first. This means that we can override methods from earlier included modules, just as we can override methods from a superclass.

Next, it will check the superclass, and any modules included in the superclass, which are also inherited by the subclass. It will keep moving up along the chain in this outward order until it reaches `BasicObject`, the last superclass for all objects in Ruby.

```ruby
# using code from above
nemo = Fish.new
fluffy = Cat.new
bob = Person.new

# all objects from Animal subclasses inherit Animal methods
nemo.characteristics    # => "I am multicellular, obtain energy through consuming food, and have nerve cells, muscles, and/or tissues."
fluffy.characteristics  # => "I am multicellular, obtain energy through consuming food, and have nerve cells, muscles, and/or tissues."
bob.characteristics     # => "I am multicellular, obtain energy through consuming food, and have nerve cells, muscles, and/or tissues."

# A Person can #walk or #swim
bob.walk                # => "I'm walking"
bob.swim                # => "I'm swimming"

# A Cat can #walk, but not #swim
fluffy.walk             # => "I'm walking"
fluffy.swim             # => NoMethodError

# A Fish can #swim, but not #walk
nemo.walk               # => NoMethodError
nemo.swim               # => "I'm swimming"
```

From the code above, we can see that a `Person` object inherits behaviors in the `Animal` superclass, as well as all the methods described in the included modules `Walkable` and `Swimmable`. The `Cat` class, on the other hand, does not have the `Swimmable` module in its method lookup chain, so calling the `#swim` method on a `fluffy` throws a `NoMethodError`. Similarly, the `Fish` class does not have the `Walkable` module in its method lookup chain, so calling the `#walk` method on `nemo` results in a `NoMethodError` as well.

## Super ##

The `super` keyword allows us to call methods that are defined earlier in the [method lookup path](#method-lookup_path). When calsss from within a method `super` will search the mtethod lookup path for a method of that name and invoke.

```ruby
class Animal
  def greet
    "hello"
  end
end

def Cat < Animal
  def greet
    "meow" + super "meow meow
  end
end

def Dog < Animal
  def greet
    "ruff" + super + "woof bark!"
  end
end

kirree = Dog.new
tibber = Cat.new

kirree.greet    # => "ruff hello woof bark!"
tibber.greet    # => "meow hello meow meow"
```

Above, we have the superclass `Animal` which defines a `#speak` instance method. The `Dog` and `Cat` subclasses both also have a `#speak` method which overrides the inherited `#speak` from `Animal`.

We can still access the `Animal#speak` method from within the overriding `#speak` methods due to the call to `super`. In this case, `super` returns the value from the `Animal#speak` method, the string `"hello"`. We can see how this is concatenated into an appropriate greeting for both our `Dog` object `kirree` and our `Cat` object `tibber`.

`super` is most commonly used with `initialize` and other *constructor* methods. This allows us to extract more generalized code used for teh construction of an object to a superclass, while still completing more specialized logic in the initiailization for an object of a subclass.

```ruby
class Car
  attr_reader :make, :model, :color, :doors
  
  def intialize(make, model, color)
      @make = make 
      @model = model
      @color = color
   end
   
   def to_s
    "A #{color} #{make} #{model} with #{doors} doors."
   end
end

class SportUtilityVehicle < Car
  def initialize(make, model, color)
    super
    @doors = 5
  end
end

class SportsCar < Car
  def initialize(make, model, color)
    super
    @doors = 2
  end
end

mama = SportUtilityVehicle.new('Nissan', 'Armada', 'silver')
dada = SportCar.new('Chevrolet', 'Challenger', 'white')

puts mama   # => "A silver Nissan Armada with 5 doors"
puts dada   # => "A white Chevrolet Challenger with 2 doors."
```

In the above code, we define the `Car` superclass `initialize` method to take three arguments: `make`, `model`, and `color`. These values are each assigned to an instance variable which describes an attribute for the new `Car` object. Further, each subclass (`SportUtilityVehicle` and `SportCar`) invokes that inherited `initialize` method by using the `super` keyword.

By default, `super` will take any arguments passed to the method that calls it and pass them along to the method that it invokes. Therefore, when `super` invokes the `Car#initialize` method for each instantiation, the `make`, `model`, and `color` attributes are assigned to each instance of the `Car` subclass appropriately.

Because the subclasses also differe in the more specific attribute `@doors`, we include this more particular value in the various subclass' `initialize` method. This is shown when we output each subclass' instantiation as a string and the various attributes are all listed.

Be careful, however, when dealing with inherited / overriding methods that contain a different number of arguments. `super` alone will always pass along *all* the arguments passed to the method that invokes it, so sometimes it is necessary to pick and choose which ones you need.

To pass along certain selected arguments with `super`, pass them in explicitly like so: `super(arg1, arg2)`

To call super without passing any arguments, add `()` to the end of the method call like so: `super()`

```ruby
# passing along only some arguments
class Pet
  def initialize(name)
    @name = name
  end
end

# this will not work
class Cat < Pet
  def initialize(name, personality)
    super     # passes two arguments Pet#initialize expects only one
    @personality = personality
  end
end

felix = Cat.new('Felix', 'playful')
# => ArgumentError (wrong number of arguments (given 2, expected 1))

# this will work
class Cat < Pet
  def initialize(name, personality)
    super(name) # passes only the `name` argument to Pet#initialize
    @personality = personality
  end
end

felix = Cat.new('Felix', 'playful')
# => #<Cat:0x000055e2ac7e4908 @name="Felix", @personality="playful">
```

In the code above, the first `Cat` class definition has the `initialize` method call `super` by itself. By default, this means that `super` will pass both arguments `name` and `personality` given to `Cat#initialize` along to `Pet#initialize` when a new `Cat` object is instantiated. However, `Pet#initialize` only expects one argument, `name`. Therefore, when we try to instantiate a new `Cat` object `felix`, this will result in an `ArgumentError`.

The second `Cat` class definition explicitly passes only the argument `name` when `super` is invoked. In this case, `super` will pass `name` to the `Pet#initialize` method, which is what it expects. Therefore, when we instantiate a new `Cat` object `felix`, the object is creates and assigned the `name` `'Felix'` due to the implementation of `super`. It is also assigned the `personality` `'playful'` due to the implementation of `Cat#initialize`.

```ruby
# calling super with no arguments

class Animal
  def initialize
  end
end

# this will not work
class Pet < Animal
  def initialize(name)
    super   # passes the argument `name` to Animal#initialize
    @name = name
  end
end

felix = Pet.new('Felix')
# => ArgumentError (wrong number of arguments (given 1, expected 0))

# this will work
class Pet < Animal
  def initialize(name)
    super()
    @name = name
  end
end

felix = Pet.new('Felix')
# => #<Pet:0x000055f1e7932f18 @name="Felix">
```

In the code above, the first `Pet#initialize` defintion has the call to `super` on its own, which by default will pass along the argument `name` to the `Animal#initialize` method. However, the `Animal#initialize` method takes no arguments. Therefore, when we try to instantiate a new `Pet` object `felix`, Ruby will throw an `ArgumentError`.

In the second `Pet` class definition, `Pet#initialize` calls `super` with two parentheses like so `super()`. Called this way, `super` does not pass along any arguments to the `Animal#initialize` method, which is what it expects. Therefore, when we try to instantiate a new `Pet` object `felix`, the code will execute and `new` will return the `Pet` object we expect.

## Object Methods ##

`Object` is the default root of all Ruby objects. That means that every class that is created inherently subclasses from the `Object` class. `Object` is built into Ruby and comes with many critical methods. Because `Object` is the parent of all other created subclasses, its methods are available throughout *all* other classes, including *any* custom class you might create.

```ruby
class Animal; end
class Plant; end
class Fungus; end

# all created classes have Object as defacto parent
Animal.superclass     # => Object
Plant.superclass      # => Object
Fungus.superclass     # => Object

# therefore all objects have access to Object instance methods
mammal = Animal.new
flower = Plant.new
mushroom = Fungus.new

mammal.inspect                  #  => "#<Animal:0x000055f1e7663508>"
mammal.instance_of?(Animal)     # => true
mammal.instance_of?(Plant)      # => false
mammal.instance_of?(Object)     # => false
mammal.is_a?(Animal)            # => true
mammal.is_a?(Plant)             # => false
mammal.is_a?(Object)            # => true
mammal.object_id                # => 260

flower.inspect                  #  => "#<Plant:0x000055f1e79c1880>"
flower.instance_of?(Plant)      # => true
flower.instance_of?(Animal)     # => false
flower.instance_of?(Object)     # => false
flower.is_a?(Plant)             # => true
flower.is_a?(Animal)            # => false
flower.is_a?(Object)            # => true
flower.object_id                # => 280

mushroom.inspect                #  => "#<Fungus:0x000055f1e79332d8>"
mushroom.instance_of?(Fungus)   # => true
mushroom.instance_of?(Animal)   # => false
mushroom.instance_of?(Object)   # => false
mushroom.is_a?(Fungus)          # => true
mushroom.is_a?(Animal)          # => false
mushroom.is_a?(Object)          # => true
mushroom.object_id              # => 300
```

**Make certain you do not accidentally override important methods that are originally defined in the Object class**. This can have far reaching effects on the code, and cause some basic principles about objects in your program to stop functioning, or function differently.

One such example is the `Object` method `send`. This is ostensibly another way for an object to call a method, in which a symbol or string is passed that represents the method you want to call. Be sure not to name any of your custom defined methods `send`, or use the name of any other particularly useful method defined in the `Object` class.

There are a few exceptions to this, notably `to_s`, which is commonly overridden when we want a different string representation of an object. Other methods that tend to be overridden include methods of equivalence and comparison such as `==` and `<=>`.

## Variable Scope with Inheritance ##

### Instance Variables ###

[Instance Variables](./classes_object.md#instance-variables) that are initialized in a superclass are available in instances of a subclass.

```ruby
class Pet
  def initialize(name)
    @name = name
  end
end

class Dog < Pet
  def speak
    puts "Arr roo roo!!! My name is #{@name}!"
  end
end

kirree = Dog.new('Kirra')

kirree.speak    # => Arr roo roo!!! My name is Kirra!
```

In the above code, we have a superclass `Pet` and a subclass that inherits from it, `Dog`. The `Dog` class inherits the `intialize` method from `Pet` which contains the instance variable `@name`. Therefore, we can access this instance variable through inheritance without ever utilizing the `Pet` class. This is shown with the implementation of the `Dog#speak` method, which accesses the instance variable `@name` to create a unique output for each instance of `Dog`.

We can see this demonstrated when we initialize a new `Dog` object `kirree` and the call the `#speak` method on it. The method outputs the string `'Arr roo roo!!! My name is Kirra!'` so we know that the `Dog` class has access to the instance variable `#name`, which is output using string interpolation in the string; furthermore, notice that we are doing this by accessing the instance variable directly and not relying on an inherited getter method's return value.

IF inherited methods from a superclass that initialize an instance variable are overridden, the variable will never be initialized, and it will return `nil` when invoked.

Given the above example, see what happens when we override the `Pet` initialize method with one that does not initialize the instance variable `@name`.

```ruby
class Pet
  def initialize(name)
    @name = name
  end
end

class Dog < Pet
  def initialize(name); end

  def speak
    puts "Arr roo roo!!! My name is #{@name}!"
  end
end

kirree = Dog.new('Kirra')

kirree.speak    # => Arr roo roo!!! My name is !
```

In the code above, our `Dog#initiailize` method overrides the `Pet#intialize` method. `Dog#initialize` never initializes the `@name` instance variable; therefore, when we invoke `#speak` on `kirree`, the call to `@name` return `nil` and the string `'Arr roo roo!!! My name is !'` is output.

Instance variable can also be inherited through interface inheritance, i.e. from modules that are included within the class. However, these variables must also be initialized, or else they return a value of `nil`. Unlike classes, modules do not have the capacity for object instantiation, so if the instance variable in uqestion is initialized within a method, that method must be called to complete the initialization process.

```ruby
module Cuddleable
  def can_cuddle
    @cuddles = true
  end
end

class Offspring
  def initialize(name)
    @name = name
  end
end

class FirstBorn < Offspring
  include Cuddleable

  def speak
    puts "Fire trutchs!"
  end

  def cuddle
    if @cuddles
      puts "Tank tu Dadd-dy"
    else
      puts "WAAAAHHHH!!! NOOOO!"
    end
  end
end

rhone = FirstBorn.new('Rhone')

rhone.cuddle        # => WAAAAHHHH!!! NOOOO!
```

In the above example, the instance variable `@cuddles` is initialized in the module `Cuddleable`; however, we never invoke the method in which it is initialized `#can_cuddle`. Therefore, when we instantiate a new `FirstBorn` object `rhone` and invoke the `cuddle` method on it, the conditional inside the method will evaluate to `false` and the string `'WAAAAHHHH!!! NOOOO!'` will be output. This is because the `@cuddles` instance variable was never initialized and returns a value of `nil`, which evaluates to false.

We can fix this by calling hte `#can_cuddle` method on the `rhone` `FirstBorn` instance, which initializes the `@cuddles` variable. In this case, the conditional inside `#cuddle` evaluates to `true` and the string `'Tank tu Dadd-dy'` is output.

```ruby
module Cuddleable
  def can_cuddle
    @cuddles = true
  end
end

class Offspring
  def initialize(name)
    @name = name
  end
end

class FirstBorn < Offspring
  include Cuddleable

  def speak
    puts "Fire trutchs!"
  end

  def cuddle
    if @cuddles
      puts "Tank tu Dadd-dy"
    else
      puts "WAAAAHHHH!!! NOOOO!"
    end
  end
end

rhone = FirstBorn.new('Rhone')

rhone.can_cuddle
rhone.cuddle        # => Tank tu Dadd-dy
```

### Class Variables ###

[Class variables](./classes_object.md#class-variables) from a superclass are available to all subclasses via inheritance. Class variables do not require methods that explicitly initialize them as instance variables do.

However, only one class variable is available across all subclasses. This means that any alterations made to a class variable from a subclass can change the value of the class variable across *all* classes that inherit it, including the superclass in which it is originially defined.

```ruby
class Pet
  @@scientific_name = 'animal domesticus'

  def initialize(name)
    @name = name
  end

  def self.scientific_name
    @@scientific_name
  end
end

class Dog < Pet
  @@scientific_name = 'canis lupis familiaris'

  def speak
    puts "Arr roo rooo rooooo!"
  end
end

puts Pet.scientific_name    # => 'canis lupis familiaris'
puts Dog.scientific_name    # => 'canis lupis familiaris'
```

In the above code, we initialize the class variable `@@scientific_name` and assign it to the string `'animalus domesticus'` in the superclass `Pet`. Then, in the subclass `Cat` (which inherits from `Pet`) we override the value of the class variable and change it to the string 'canis lupis familiaris'`. Note that this will change the value of`@@scientific_name` regardless of whether we access it from the `Dog` subclass or the `Pet` superclass.

This is shown when we output the value returned by calling the class method `scientific_name` on `Pet` and `Dog`, both of which output the string 'canis lupis familiaris'
