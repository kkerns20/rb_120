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

The `equal?` method is a method used to determine whether two variales not only have the same value, but whether they reference the same object.

```ruby
a = 'hey there buck'
b = 'hey there buck'
a == b                # => true
a.equal? b            # => false

a = [1, 2, 3, 4]
b = [1, 2, 3, 4]
a == b                # => true
a.equal? b            # => false
```

Be careful not to override this method by creating your own custom `equal?`. It's much better to implement a custom `==` method as described above instead.

You can also compare two object's `object_id`'s to get the same result as using `equal?`.

Every object has a method called `object_id` that returns a unique identifying number for that object. This method is a good way to determine if two variable are pointing to the same obejct or if they merely hold identical values. Two different variables that are pointing to the same object will both return the same number. That number is *completely unique* so if the variable in question references a different object, `object_id` will return a different number entirely.

```ruby
# strings
str1 = 'what the f'
str2 = 'what the f'

p str1.object_id                      # => 60 <or some randomly generated num>
p str2.object_id                      # => 80 <or some randomly generated num>

p str1.object_id == str1.object_id    # => false
puts

# arrays
arr1 = [1, 2, 3, 4]
arr2 = [1, 2, 3, 4]

p arr1.object_id                      # => 100
p arr2.object_id                      # => 120
p arr1.object_id == arr2.object_id    # => false
puts

# symbols
sym1 = :whatsit
sym2 = :whatsit

p sym1.object_id == sym2.object_id    # => true
puts

# integers
int1 = 20
int2 = 20
p int1.object_id == int2.object_id    # => true
```

In the above code, we initialize two string objects and compare their distinct `object_id`'s. The object id for `str1` is different from that of `str2` so they are two separarte obejcts in memory. Similarly, for the two initialized array object `arr1` and `arr2`.

Then we compare two symbol objects `sym1` and `sym2`, which are apparently the same object in memory, despite us initializing the two symbols `:whatsit`. Similarly, `int1` and `int2` both reference the same object in memory, the integer `20`.

This is because both symbols and integers are **immutable objects**. Though it may look like we are initializing more than one symbol or integer, in reality, this is not the case. In Ruby, immutable objects that have the same value actually represent *the same object in memory*. Therefore, there is only ever one symbol `:whatsit` or integer `20`. Any assignment statements that involve it will cause the variable to reference the same object in memory.

### `Operators#===` ###

The `===` method is an instance method that is used implicitly with case statements. When `===` compares two objects it's really asking, *if the calling object is a group, does the object passed as an argument belong in that group?*.

```ruby
a = 'hello'
b = 'hello'
a === b         # => true
# essentially asking does ['hello'] include 'hello'?

a = 1
b = 1
a === b         # => true
# essentially asking does [1] include 1?

a = 'words'
String === a    # => true
# does the String class include 'words'?

b = 5
(1..9) == b     # => true
# does the Range (1..9) include 5?

String === b    # => false
# does the String class include 5?
```

Behind the scenes, a case statement is using `===` to compare the value in the `when` clause with the value declared by `case`.

```ruby
num = 42

case num
when (1..25)    then puts 'first quarter'
when (26..50)   then puts 'second quarter'
when (51..75)   then puts 'third quarter'
when (76..100)  then puts 'last quarter'
else                 puts 'not in range'
end

# => second quarter
```

Note that defining a custom behavior for `===` is not often necessary, because using a custom class in a case statement is pretty unusual.

### eql? ###

## Fake Operators ##

### Equality Methods ###

### Comparison Methods ###

### Right and Left Shift ###

### The Plus Method ###

### Element Setters and Getters ###
