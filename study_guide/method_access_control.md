# Method Access Control #

**Method access control**
: implemented through the use of *access modifiers* that restrict access to methods within a class. In Ruby, this is accomplished with the `public`, `private`, and `protected` access modifiers.

## Public ##

A public method is one that is available to anyone who knows either the class or object name. It is readily available for use throughout the program, whether inside or outside of the class.

A class's **interface** consists only of it's public methods. This describes how other classes and objects interact with this clasds and its instances.

```ruby
# a method defined within a class is public by default
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def introduce
    puts "Hi, my name is #{name}"
  end
end

# we can call public methods anywhere within the program
rhone = Person.new('Rhone')

# we can call public methods anywhere within the program
rhone.name        # => 'Rhone'
rhone.introduce   # => "Hi, my name is Rhone"
```
