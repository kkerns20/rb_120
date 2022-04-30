# Accessor Methods #

## What are setters and getters? ##

**Accessor Methods**
: special methods used with [instance variables](./classes_object.md) that allow us to *get* or *set* the data contained within the state of an object.

## Getter Methods ##

Outside of the class, we need a specifically defined method to access the values stored within the instance variables associated with an object. We can define this method within the class so that when we retrieve the value in question wherever the object is accessible.

```ruby
# This will not work properly
class Superhero
  def initialize(name)
    @name = name
  end
end

wolverine = Superhero.new('Logan')
wolverine.name
# => NoMethodError: undefined method 'name'

# This will work
class Superhero
  def initialize(name)
    @name = name
  end

  def name
    @name     # technically, we can call this method anything
  end
end

wolverine = Superhero.new('Logan')
wolverine.name
# => 'Logan'
```

In the code above, we define the `Superhero` class such that an instance of `Superhero` contains the attribute `@name`. In the first example, there is no getter method defined, so when we call `wolverine.name` on our `Superhero` object, we get a `NoMethodError`.

The second example defines the instance method `#name` which returns the value referenced by the instance variable `@name`. We can call this method anythign we want (`show_name`, `get_name`, etc...), but by convention it's best to use the name of the instance variable you want to return.

This method returns the value associated with `@name` for the individual object that calls it. In this case, that's the string `'Logan'`, which is returned by the invocation `wolverine.name`.

Getter methods like these can also be used within the class. In fact, it's better to access the value of an instance variable through a getter method than using the instance variable directly. This makes for more flexible and easy to maintain code (because changes need only be made where the getter method is defined).

When using the getter methods within the class, simply drop the `@` at the begining of the instance variable (this is why we call getter methods by the same name as the attribute). Calling a method without an explicit caller causes Ruby to set the default caller to `self`. As long as you are scoped at the object level(i.e. within an instance method), this will refer to the object, meaning we can call the getter method name on its own.

```ruby
class Superhero
  def initialize(n)
    @name = n         # intialize @name
  end

  def name
    @name             # define getter method name
  end

  def introduce       # access @name through getter method #name
    puts "Sup? It's your friendly neighborhood #{name}!"
  end
end

spider_man = Superhero.new("Spider-Man")
spider_man.name             # => Spider-Man
spider_man.introduce        # => Sup? It's your friendly, neighborhood Spider-Man!
```
