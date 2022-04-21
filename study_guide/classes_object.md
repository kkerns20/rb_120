# Classes and Objects #

- [Objects](#objects)
- [Classes](#classes)
- [Object Instantiation](#initializing-a-new-object)
- [Instance Variables](#instance-variables)
- [Instance Methods](#instance-methods)
- [Class Variables](#class-variables)
- [Class Methods](#class-methods)

## Objects ##

In Ruby, anything that has a **value** can be considered an **object**. Numbers, strings, arrays, clases and modules are all considered to be *objects*. Methods, blocks, and variables *are not objects*.

```ruby
# objects
'hi'.is_a?(Object)               # => true
20.is_a?(Object)                 # => true
['1', 2, :3, nil].is_a?(Object)  # => true
Hash.new.is_a?(Object)           # => true

module Readable
  def what_am_i
    puts "You're a wizard (read: Object), Harry!"
  end
end

class Wizard
  include Readable
end

Readable.is_a?(Object)           # => true
Wizard.is_a?(Object)             # => true
harry = Wizard.new 
harry.is_a?(Object)              # => true
harry.what_am_i                  # => "You're a wizard (read: Object), Harry!"
```

Objects are created from **classes** (which are another type of Object)

*Class*
: a blueprint

*Object*
: something built from that blueprint

Individual object can contain different information, but can still be instances of the same class.

```ruby
str1 = "I am a String object"
str2 = "I am a different String object"

puts str1.class                         # => String
puts str2.class                         # => String
puts str1                               # => "I am a String object"
puts str2                               # => I am a different String object"
```

## Classes ##

**class**
: the basic outline of *attributes* and *behaviors* belonging to a particular kind of object.

Attributes represent the *state* of an object, such as the different values and data that make up that individual object. Behaviors describe what objects of that class should be able to do, that is the **methods* they can invoke

[A note on terms](#a-note-on-terms)

Use a **class definition** to define a custom class. These are contructed with teh keywords `class...end`. Class names use the CamelCase naming convention (they are technically constants, so it's important to capitalize them). Files that contain your custom class definition should be named with snake_case and reflect their contents.

```ruby
class Person
  # initialization behavior for class instance (object)
  # constructor method
  def initialize(name, age)
    @name = name
    @age = age
  end

  # appropriate behavior for class instance (object)
  def introduce
    puts "Hello, my name is #{@name}"
  end
end

# Creates a new instance of Person and stores it in a variable
slim_shady = Person.new('Eminem', 43)
slim_shady.introduce    # => "Hello, my name is Eminem"
```

Within a class, we define [instance variable](#instance-variables) to keep track of different attributes of each object that is created. [Instance methods](#instance-methods) expose the behavior available to *all* objects of a class.

Below, we create two different Fish objects. They both have an instance variable `@type`, and each points to a different value. In the case of `nemo` it references the string `"clownfish"`, and in the case of `bruce` it references the string `'shark'`. However,both fish objects have access to the behavior defin3ed by the instance method `#swim`. When we invoke `#swim` on any given `Fish` instance, it will display that object's attribute `@#type`.

```ruby
class Fish
  def initialize(type)
    # instance variable stores data pertaining to particular instance
    @type = type
  end

  # instance method defines behavior available to all objects of that class
  def swim
    puts "The #{@type} is swimming!"
  end
end

nemo = Fish.new('clownfish')    # => #<Fish:0x0000563bc8206b38 @type="clownfish">
bruce = Fish.new('shark')       # => #<Fish:0x0000563bc823dd68 @type="shark">
nemo.swim                       # => The clownfish is swimming!
bruce.swim                      # => The shark is swimming!
```

Use the `.class` method to return the class name of any object.

```ruby
'string'.class      # => String
4.class             # => Integer
[1, 2, 3].class     # => Array
nil.class           # => NilClass
true.class          # => TrueClass

# using Person class from above
bob = Person.new('Bob', 42)
bob.class           # => Person
```

## Object Instantiation ##

*Instantiation*
: creating a new object or instance from a class

We instantiate abn object from a class by calling the class method `::new`. This invokes the `#intialize` instance method for hte calling class, which defined the behavior we want to execute when a new object is initialized.

```ruby
Hash.new          # => {}
String.new        # => ''

# Person#initialize is defined to take an argument
class Person
  def initialize(name)
    @name = name
  end

  def introduce
    puts "Hi, my name is #{@name}"
  end
end

# when we call Person::new, we must pass the argument #intialize expects
ken = Person.new("Ken")  # => #<Person:0x00007fcb3dca88b0 @name="Ken"> 
ken.introduce            # => Hi, my name is Ken (returns nil)

# Or we could defined intialize to supply a default argument
class Person
  def initialize(name='John Doe')
    @name = name
  end

  def introduce
    puts "Hi, my name is #{@name}"
  end
end

# No argument is supplied but the default value is assigned to @name
anon = Person.new         # => #<Person:0x000055e2d01e8968 @name="John Doe">
anon.introduce            # => "Hi, my name is John Doe"
```

The `#initialize` instance method that gets invoked each time we create a new object is know as a **constructor**, because it is triggered upon creation and it helps us to create that new object in the desired way.

We can put any kind of code within the `#intialize` method that we want, but it's best to keep it to what is strictly necessary for the object's construction.

```ruby
class Thing
  def intialize
    puts "A thing has been intialized!"
  end
end

Thing.new     # => "A thing has been intialized!"
```

## Instance Variables ##

**Instance variables** are used to tie data to an individual object. They track the individual attributes and states for that specific instance of a class. They are useful for tracking the unique state of particular objects, outside of any commonalities gained from shared class.

We differentiate instance variables by adding an `@` to the beginning of their name.

In the code below, we initialize two new `Person` objects and assign them to the variable `jack` and `jill`. When hte objects are initialized, we pass each the string `'Jill'` and `'Jack'` respectively. `'Jill'` is assigned to the `@name` instance variable for the `Person` object referenced by `jill`, and `'Jack'` is assigned to the `@name` instance variable for the `Person` object referenced by `jack`. This is demonstrated when we call the `#introduce` method on both objects, and each individual `@name` value is output.

```ruby
class Person
  def initialize(n)
    @name = n
  end

  def introduce
    puts "Hi! My name is #{@name}"
  end 
end

jill = Person.new("Jill")
jack = Person.new("Jack")
jack.introduce        # => 'Hi, my name is Jack!'
jill.introduce        # => 'Hi, my name is Jill!'
```

Because instance variables track individual object state, they are scoped at the object level. That is, they *cannot* cross over between different objects, but the *are* available throughout the instance methods for any particular object.

This means that for any given object, you can access an instance variable within an instance method *without passing it in*, even if it was initialized outside of that particular instance method.

Looking at the example above, we can see this demonstrated by the fact that the `#introduce` method has access to the `@name` value for both `jack` and `jill`, despite the fact that we never pass it into the method and it is initialized in the constructor method for `Person`.

This works across all instance methods, as long as we are dealing with the same particular instance that the instance variable describes.

```ruby
class Superhero
  def initialize(n)
    @name = n
  end

  def teleport
    puts "#{@name} teleports behind the enemy"
  end

  def block
    puts "#{@name} blocks the enemy's attack"
  end

  def knockout
    puts "#{@name} knocks the enemy out cold"
  end
end

# instantiate new Superhero object deadpool, assigns "Deadpool" to @name
deadpool = Superhero.new('Deadpool')
deadpool.teleport                   # Deadpool teleports behind the enemy
deadpool.block                      # Deadpool blocks the enemy's attack
deadpool.knockout                   # Deadpool knocks the enemy out cold
# notice how all instance methods have access to @name for deadpool
```

Instance variable are available within instance methods *even if they are not initialized* because their scope is at the object level. Meaning that even if an instance variable has not been initialized, it will be recognized as a variable and Ruby will treat it as if it references the value of `nil`. This means that you can reference uninitialized instance variables without having the program throw an `NameError`

```ruby
class Cat
  def initialize(name)
    @name = name
    @personality
  end

  def assign_personality
    @personality = ['friendly', 'grouchy', 'curious'].sample
  end

  def speak
    case @personality
    when 'friendly' then puts 'purrrr'
    when 'grouchy'  then puts 'hissss'
    when 'curious'  then puts 'meow??'
    else                 puts 'meow'
    end
  end
end

tibber = Cat.new('Mr. Tibbs')
# => #<Cat:0x000055e2d0232248 @name="Mr. Tibbs">

tibber.speak      # => meow
tibber.assign_personality
tibber
# => #<Cat:0x000055e2d0232248 @name="Fluffy", @personality="grouchy">

tibber.speak      # => hissss
```

In the above code, we defined the Cat class such that the instance variable `@personality` is not initialized until we call the `#assign_personality` instance method. Therefore, when we instantiate a new `Cat` object and assign it to the variable `tibber`, it will not contain a value for `@personality` as shown with the object returned by `::new`

We might expect that calling the instance method `#speak` would result in a `NameError` being thrown, since it relies on the value referenced by `@personality` to determine its output. However, when we run the code, no `NameError` will be thrown. Rather, referencing the unitialized `@personality` returns a `nil` value. When the case statement is evaluated, the `else` will execute and we see the output of `meow`

We then invoke the `#assign_personality` instance method, which assigns a value selected at random from an array to `@personality`. We can see by examining the `fluffy` object that `@personality` now references a value of `'grouchy'`. Calling the `#speak` method again, we see the output of `'hissss'` showing htat the value referenced by `@personality` has indeed changed.

## Instance Methods ##

**Instance Methods**
: methods defined within a class that describe the behavior avaialable to *all* instances of that class. Instance methods have access to instance variables due to their scope(see above), so you can use them to track and manipulate data that tracks a particular object's state.

As can be seen in the example below, instance methods that incorporate an individual object's state can have slightly different outputs depending on the object that calls it. On the other hand, instance methods that are defined witout accessing an individual object's attributes will have the same output for all objects across the class.

```ruby
class Person
  def initialize(n)
    @name = n
  end

  def introduce
    puts "Hi! My name is #{@name}"
  end 

  def say_goodbye
    puts "See you later!"
  end
end

jill = Person.new("Jill")
jack = Person.new("Jack")

# instance method that outputs an object's @name attribute
jack.introduce        # => 'Hi, my name is Jack!'
jill.introduce        # => 'Hi, my name is Jill!'

# instance method that does not utilize the particular state of an object
jack.say_goodbye      # => "See you later!"
jill.say_goodbye      # => "See you later!"
```

## Class Variables ##

**Class variables**
: variables that are available to *every object in that class*. They contain information that is common across all instances of a class or pertinent to the class as a whole rather than information tied to a specific instance of a class.

Class variables are created by adding `@@` to the beginning of a variable name.

```ruby
class Tiger
  # class variable pertinent to all objects across class
  @@scientific_name = 'panthera tigris'

  def initialize(name)
    # instance variable pertinent to individual object
    @name = name
  end
end
```

Class variables are available within all instance methods defined for that particular class. All objects of a class share one copy of the class variable. This means they are **scoped at the class level**. Class methods can also access class variables (regardles of where they are initialized).

```ruby
class Tiger
  # class variable pertinent to all objects across class
  @@scientific_name = 'panthera tigris'

  def self.scientific_name
    @@scientific_name       # accessible from class method
  end

  def initialize(breed)
    # instance variable pertinent to individual object
    @breed = breed
  end

  def what_am_i
    # both instance and class variables accessible from instance methods
    puts "I'm a #{@breed} from the #{@@scientific_name} species"
  end
end

tony = Tiger.new('bengal')      # => #<Tiger:0x00007fd7f248a040 @breed="bengal">
tigger = Tiger.new('sumatran')  # => #<Tiger:0x00007fd7f2489fa0 @breed="sumatran">

tony.what_am_i                  # => I'm a bengal from the panthera tigris species
tigger.what_am_i                # => I'm a sumatran from the panthera tigris species
```

Note how in the above code, each instance of Tiger has it's own copy of `@@scientific_name` which can be accessed from within the instance method `#what_am_i`

We can also mutate class variables from within instance methods, which allows us to keep track of class level details that *pertain only* to the class.

```ruby
class Person
  @@people_present = 0

  def initialize(name)
    @name = name
    @@people_present += 1   # => mutable from instance method
  end

  def self.total_number_of_people
    @@people_present
  end
end

Person::total_number_of_people  # => 0
joe = Person.new('Joe')
billy = Person.new('Billy')
Person::total_number_of_people  # => 2
```

Class variables from a superclass are available to subclasses via [inheritance](./inheritance.md). The class variable is loaded when the class is evaluated by Ruby, so class variables do not require methods that explicitly initialize them.

```ruby
class Dog
  @@scientific_name = 'canis lupis familiaris'

  def initialize(name)
    @name = name
  end

  def what_am_i
    puts "My name is #{@name} and I am a #{self.class} of the #{@@scientific_name} species."
  end
end

class Collie < Dog; end
class Beagle < Dog; end
class Lab < Dog; end

lassie = Collie.new('Lassie') # => #<Collie:0x000055da088a6d98 @name="Lassie">
snoopy = Beagle.new('Snoopy') # => #<Beagle:0x000055da088e5138 @name="Snoopy">
pablo = Lab.new('Pablo')      # => #<Lab:0x000055da08921e08 @name="Pablo">

lassie.what_am_i  # => My name is Lassie and I am a Collie of the canis lupis familiaris species.
snoopy.what_am_i  # => My name is Snoopy and I am a Beagle of the canis lupis familiaris species.
pablo.what_am_i   # => My name is Pablo and I am a Lab of the canis lupis familiaris species.
```

## Class Methods ##

**Class methods**
: a type of method that we *call directly on the class itself*. We do not have ot instantiate any objects to invoke a class method, since they pertain to the class as a whole.

To define a class method, prepend the method name with the keyword `self`. In this case, `self` will refer to the class (upon which the method must be invoked).

```ruby
class Person
  @@people = []

  def initialize(name)
    @name = name
    @@people << @name
  end

  def self.show_people
    @@people.each { |name| puts name }
  end
end

jack = Person.new('Jack')
jill = Person.new('Jill')
kenny = Person.new('Kenny')
Person.show_people
  # => Jack
  # => Jill
  # => Jenny
  # returns ["Jack", "Jill", "Kenny"]
```

Class mehtods are defined by `::` in the Ruby docs. They *must* be called on the class name itself (i.e. hsh = Hash.new).

## A Note on Terms ##

- An instance variable is named by the class, but each object created from the class creates its own copy of the instance variable. It's value contributes to the overall state of the object.
  - The instance variable is actually *not* a part of the class and cannot be inherited. The subclass only knows about the variable name, and it uses that name as a reference to the value it points to.
- An attribute is an instance variable name along with it's value. It only does us any good if there is either an associated getter or setter method or both.
  - The getter and settter methods are inherited, but the attribute behind these does not get inherited.
- Every object has a state. This is the collection of all instance variables and their values as defined for an individual object. It is part of the object, not the class, and therefore is not inherited.

## Instance Methods vs. Class Methods ##

| Instance Method | Class Method |
| ---- | -----|
| Called by an individual object, which must be instantiated |Called by the class itself, no object initialization necessary |
| Defined as `def` + method_name + implementation + `end` | Keyword `self` must be added to method name in method definition within the class |
| Defines a single behavior available to an *object* of a class | Defines a behavior relevant to the *class* as a whole

```ruby
class Person
  # class variable
  @@people_present = []

  # define getter method for @name instance variable
  attr_reader :name

  # instance method for object instantiation (called with ::new)
  def initialize(name)
    @name = name
    @@people_present << name
  end

  # instance method
  def introduce
    puts "Hi, my name is #{name}!"
  end

  # class method (defined with self. in front of method name)
  def self.show_people_present
    @@people_present.each { |person| puts person }
  end
end

anna = Person.new('Anna')   # initialize new object with class method ::new
bob = Person.new('Bob')
claire = Person.new('Claire')
david = Person.new('David')

anna.introduce              # call instance method on object
  # => Hi, my name is Anna!
bob.introduce
  # => Hi, my name is Bob!
claire.introduce
  # => Hi, my name is Claire!
david.introduce
  # => Hi, my name is David!

Person.show_people_present  # call class method on the class itself
  # => Anna
  # => Bob
  # => Claire
  # => David
```
