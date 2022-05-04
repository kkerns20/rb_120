# Self #

- [Inside instance methods](#inside-instance-methods)
- [Inside class methods](#inside-class-methods)
- [Inside class definitions](#inside-class-definitions)
- [Inside mixin modules](#inside-mixin-modules)
- [Outside any class](#outside-any-class)

`self`
: a reserved keyword in Ruby that acts as a variable.

This variable always points to the object that 'owns' the currently executing code. `self` is a way of being explicit about what our program is referencing and what our intentions are as far as behavior (such as with setter methods vs. local variable initialization).

Anytime we have a method that does not have an explicit calling object, Ruby will provide an implicit `self`. For this reason, it is important to understand what `self` is referencing on any given level of code. `self` changes depending on the scope that it is used in.

```ruby
class Person
  attr_reader :name

  def initialize
    @name = name
  end

  def self.scientific_name          # explicit self, self is the class
    'homo sapiens'
  end

  def introduce
    puts "Hi! my name is #{name}"   # implicit self.name, self if the object 
  end
end
```

## Inside instance methods ##

Inside of an instance method, `self` points to the object that *calls the method*; therefore, we can assume that within an instance method `self` will always reference an object that is an instance of that particular class.

```ruby
class Thing
  def calling_object
    self
  end
end

whatsit = Thing.new
p whatsit.calling_object    # => #<Thing:0x00007fc21b9930d8>
```

Anytime we are using a setter method within an instance method, we need to prefix the setter method name with `self`. This is because a setter method takes advantage of Ruby's syntactical sugar and looks just like an assignment statement. Without the `self` caller, Ruby will assume the setter method name is local variable initialization, and we will not be able to modify the desired value of the instance variable in question.

```ruby
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def change_name(new_name)
    name = new_name
  end
end

bill = Person.new('William')
p bill.name                   # => "William"
bill.change_name('Bill')
p bill.name                   # => "William"
```

In the above code, we define an instance method `change_name` that tries to use the `name=` setter method to reassign the value of `@name`; however, because we are not using the keyword `self` within the instance method, Ruby assumes that we are instead initializing a local variable `name`, to which we assign the string object passed as an argument.

When we call `change_name` on the `Person` object `bill` and pass the string `'Bill'` as an argument, this string is assigned to local variable `name` within the method and the instance variable `@name` remains pointing to the string `'William'`. This can be shown when we call the getter method `name` which still returns `'William'`.

```ruby
# this will work
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def change_name(new_name)
    self.name = new_name
  end
end

bill = Person.new('William')
p bill.name                   # => "William"
bill.change_name('Bill')
p bill.name                   # => "Bill"
```

In the above example, we are using `self` to explicitly call the `name=` setter method. This works because `self`references the calling object for the method `change_name`, in this case the `Person` object `bill`. When the code executes at that time, we really see `bill.name=('Bill')`, which tells Ruby that we are calling the setter method for the instance variable `@name` rather than initializing local variable `@name`.

The success of this can be demonstrated when we use the getter method `name` with `bill` and the return value has indeed changed from `'William'` to `'Bill'`.

## Inside class methods ##

## Inside class definitions ##

## Inside mixin modules ##

## Outside any class ##
