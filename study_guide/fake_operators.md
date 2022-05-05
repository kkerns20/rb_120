# Fake Operators and Equality #

- [Equivalence](#equivalence)
  - [==](#operator)
  - [equal? and object_id](#equal-and-objectid)
  - [===](#operators)
  - [eql?](#eql)
- [Fake Operators](#fake-operators)
  - [Equality Methods](#equality-methods)
  - [Comparison Methods](#comparison-methods)
  - [Right and Left Shift](#right-and-left-shift)
  - [The Plus Method](#the-plus-method)
  - [Element Setters and Getters](#element-setters-and-getters)

A lot of operators in Ruby are really method calls using the disguise of Ruby's syntactical sugar to utilize a more visually appealing syntax.

Because they are really methods, we can define our own implementations of them within our custom classes. Doing so overrides the fake operators with out own implementation, so it's important to follow the conventions established for each within the Ruby standard library.

## Equivalence ##

**Equivalence**
: the idea of equality. Because `==` in Ruby is in fact a *method* and not an operator, we can define custom ideas of equality for our custom objects.

Many of the built in Ruby object classes already have custom definitions that determines what we are checkin for when we check for equality.

```ruby
a = 'hello world'
b = 'hello world'

# check to see if they are the same object in memory
a.equal?(b)     # => false

# checks to see if they reference identical values
a == b          # => true
```

### Operator#== ###

The `==` method has a special syntax to make it look like a normal operator that is part of Ruby's syntactical sugar. IT is not, however, an operator but rather an instance method. We can therefore assume that the value used for comparison of each calling instance is determined by its class.

The original `==` is defined in `BasicObject`, from which all other classes in Ruby descend; therefore, all classes have a `==` method available to them. But many classes define their own `==` method which overrides the superclass method and specifies the unique value each class should use for comparison.

By default, the `==` method will check to see if the two objects being compared are the same object in memory (just like the `equal?` method shown above). In order to check unique values for equality in our custom defined classes, we need to override the `==` implementation from `BasicObject`.

```ruby
# using the default `==` method
class Student
  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id = id
  end
end

rhone_1 = Student.new('Rhone', 33020)
rhone_2 = Student.new('Rhone', 33020) 

p rhone_1 == rhone_2      # => false
```

In the above code, we define the class `Student` such that its instances exhibit the attributes `name` and `id`. Then we initialize two `Student` objects and assign identical values to both attributes; however, when we invoke the `==` method on teh instance reference by `rhone_1`, the implementation of `==` is still that of `BasicObject`. `==` is comparing the two objects to see if they are the *same object in memory*. `rhone_1` and `rhone_2` reference two separate objcts so `==` returns `false`.

```ruby
# using the default `==` method
class Student
  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id = id
  end

  def ==(other_student)
    id = other_student.id
  end
end

rhone_1 = Student.new('Rhone', 33020)
rhone_2 = Student.new('Rhone', 33020) 

p rhone_1 == rhone_2      # => true
```

In the above code, we define the class `Student such that its intances exhibit the attributes`name` and `id`. Then we initialize two`Student` objects and assign identical values to both attributes; however, `Student` also has a custom `==` method defined which overrides the inherited behavior from `BasicObject`. In this case, we are using`Integer#==` to compare the `id` values from teh two instance of `Student`.`rhone_1` and `rhone_2` have identical `id` values, so the `Student#==` method will return `true`.

We can define our custom `==` methods in whatever way makes the most sense for the object in question. In this case, we choose to compare `id` numbers as two students of the same name may not be the same student. However, a uniqe id number is assigned to each student enrolled so that is what we choose to assess for finding equivalence.

Note that almost every core class in Ruby has their own implementation for `==`. We can rely on these impletmentations as well when defining our own `==`.

When you define a custome `==` method, it automatically assumes the same implementation for `!=`. That means that given the `Student` class example above, the following will also work:

```ruby
wit_1 = Student.new('Bob', 67890)
rhone_1 != wit_1                        # => true
```

### equal? and object_id ###

### `Operators#===` ###

### eql? ###

## Fake Operators ##

### Equality Methods ###

### Comparison Methods ###

### Right and Left Shift ###

### The Plus Method ###

### Element Setters and Getters ###
