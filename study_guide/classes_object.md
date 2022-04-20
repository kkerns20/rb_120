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
jill.introduce
jack.introduce
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

## Instance Methods ##

## Class Variables ##

## Class Methods ##
