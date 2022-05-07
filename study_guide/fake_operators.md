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

The `eql?` method determines if two objects contain the same value and if they are of the same class. It's used most frequently by hashes to determine equality among it's members (because keys must be unique). It's not used very often.

## Fake Operators ##

Ruby's **syntactical sugar** allows us to use more natural expressions with many methods, and this make them look like operators. It's important to know which of these so called "operators" is a *method* that's acting as a *fake operator* beucase these can be custom defined for our custom classes to change their default behavior.

Method | Opertator | Description
------ | --------- | -----------
no | `.`, `::` | Method/constant resolution operators
yes | `[]`, `[]=` | Collection element getter and setter method
yes | `**` | Exponential operator
yes | `!`, `~`, `+`, `-` | Not, complement, unary plus and minus (method names for the last two are `+@` and `-@`)
yes | `*`, `/`, `%` | Multiply, divide, and modulo
yes | `+`, `-` | Plus, minus
yes | `>>`, `<<` | Right and left shift
yes | `&` | Bitwise "and"
yes | `^`, `|` | Bitwise exclusive "or" and regular (inclusive) "or"
yes | `<=`, `<`, `>`, `>=` | Less than/equal to, less than, greater than, greater than/equal to
yes | `<=>`, `==`, `===`, `!=`, `=~`, `!~` | Equality and pattern matching (`!=` and `!~` cannot be directly defined)
no | `&&` | Logical "and"
no | `||` | Logical "or"
no | `..`, `...` | Inclusive range, exclusive range
no | `? :` | Ternary if-then-else
no | `=`, `%=`, `+=`, `!=`, `&=`, `>>=`, `<<=`, `*=`, `**=`, `{}` | Assignment (and assignment shortcuts) and block delimiter

Note that overriding fake operators *can* be dangerous. Since there are so many, we never *really* know what an expression like `obj1 + obj2` will do.

### Equality Methods ###

One of the most common fake operators to override is `==`. This also provides us with an `!=` method. See [equivalence](#equivalence).

### Comparison Methods ###

Implementing our own custum behaior for comparison methods gives us a nice syntax we can use to copare our custom objects. By default, the comparison methods do not know how or what values to compare. We define them to tell them which values to we want to compare, again relying on specific implementations for compariosn methods within Ruby's built in classes.

Note that unlike `==` and `!=`, defining `>` does **not** automatically give us `<`. If we want to use both, we have to define them both within our class.

```ruby
# this will not work
class Athlete
  attr_accessor :name, :height

  def initialize(name, height)
    @name = name
    @height = height #height value is in meters
  end
end

shaquille = Athlete.new('Shaq', 2.16)
kobe = Athlete.new('Kobe', 1.98)

puts "#{shaquille.name} is taller that #{kobe.name}" if shaquille > kobe
# => NoMethodError: undefined method '>'
```

In the above code, we define a class `Athlete` whose instances exhibit the attributes `name` and `height`. We then initialize two new `Athlete` objects `shaquille` and `kobe`. `shaquille` is assigned an `@height` of 2.16 meters during initialization and `kobe` is assigned a `@height` of 1.98 meters during initialization. We then try to compare the two `Athlete` objects with `>` to see which one is taller.

However, we have no defined `>` method in our `Athlete` class. `>` is in fact an instance method we need to define for the class so Ruby knows which values within the object to compare, and not an operator as it might appear.

```ruby
# this will not work
class Athlete
  attr_accessor :name, :height

  def initialize(name, height)
    @name = name
    @height = height #height value is in meters
  end

  def >(other_athlete)
    height > other_athlete.height # relies on float#>
  end
end

shaquille = Athlete.new('Shaq', 2.16)
kobe = Athlete.new('Kobe', 1.98)

puts "#{shaquille.name} is taller that #{kobe.name}" if shaquille > kobe
# => Shaq is taller that Kobe
```

In the above code, we define a custom `>` that tells Ruby what values to compare within our `Athlete` objects. In this case, it's the value referenced by the instance variable `@height`. We rely on the `Float#>` method to implement our custom `Athlete#>` method. Then when we call `Athlete#>` on the `shaquille` object and pass it the `kobe` object as an argument, Ruby executes the `Athlete#>` implementation, which compares the `@height` of each object. In this case, `shaquille` has a greater height than `kobe` so `'Shaq is taller than Kobe'` is output.

Note that the above code does not automatically generate an `Athlete#<` method. If we wish to utilize this, we'll need to define it individually, which we can do quickly like:

```ruby
def <(other_athlete)
  !self.>(other_athlete)
end
```

### Right and Left Shift ###

When implementing fake operators, choose functionality that makes sense when used with the operator-like syntax that you are defining.

For example, custom defining an `<<` or `>>` method can provide a good interface when working with an object that represents a collection. For a class that describes a collection like this, we can even utilize some kind of guard clause within our `<<` implementation to reject adding items unless some criteria is met.

```ruby
clas= GradeLevel
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(student)
    # guard class, assume we have a Student#passed_previous_grade? defined
    # return unless student.passed_previous_grade?
    members.push student
  end
end

# define Student class for collaborator objects
class Student
  attr_accessor :name, :gpa

  def initialize(name, gpa)
    @name = name
    @gpa = gpa
  end
end

juniors = GradeLevel.new('Juniors')
jon = Student.new('Jon', 3.9)
rory = Student.new('Rory', 3.91)
phil = Student.new('Phil', 3.75)

juniors << jon
juniors << rory
juniors << phil

p juniors.members
# [#<Student:0x00007f5ac42359f8 @name="Jon", @gpa=3.9>, 
   #<Student:0x00007f5ac4235958 @name="Rory", @gpa=3.91>, 
   #<Student:0x00007f5ac42358b8 @name="Phil", @gpa=3.75>]
```

In the above code, we define two classes. A= GradeLevel` class, which is a collection of `Student` collaborator objects, represented by the instance variable `@members` which points to an empty array upon initialization. We define a custom left shift method `<<`, which allows us ot add`Student` collaborator objects to the `@members` array using Ruby's syntactical sugar. We rely on the `Array#push` method for implementation so that we can mirror the pattern set forward by Ruby's built in object's behavior with `<<`.

This is show to operate the way we want when we instantiate a new= GradeLevel` object, `juniors` and add the three `Student` objects `jon`,`rory`, and`phil` to it. We can see by inspecting the `members` attribute for our `juniors` grade level that it now consists of an array of three `Student` objects.

### The Plus Method ###

Though somewhat unintuitive, `+` and other arithmetic operators are actually methods and not operators at all. This means that we can also custom define arithmetic operations for our custom classes. As with `<<` we'll want to try to keep our implementation within the pattern of behavior that is set up by the built in Ruby classes for `+`.

In this case, we notice that `+` should eb either *incrementing* or *concatenating* the calling object with an argument. Let us also notice that `+` returns a value *of the same class* of the calling object and the argument passed to it. This means that we don't necessarily want to return the value we get from whatever `#+` method we utilize in our implementation, we want to initialize a new object of the class we are defining to represetn our incremented or concatenated value.

```ruby
clas= GradeLevel
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(student)
    members.push student
  end

  def +(other_grade)
    result_group = GradeLevel.new('New Group')
    # Use Array#+ to change the @members of the new grade to return
    result_group.members = members + other_grade.members
    result_group
  end
end

# define Student class for collaborator objects
class Student
  attr_accessor :name, :gpa

  def initialize(name, gpa)
    @name = name
    @gpa = gpa
  end
end

juniors = GradeLevel.new('Juniors')
juniors << Student.new('Jon', 3.9)
juniors << Student.new('Rory', 3.91)
juniors << Student.new('Phil', 3.75)

seniors = GradeLevel.new('Seniors')
seniors << Student.new('Jordan', 3.25)
seniors << Student.new('Ernie', 3.45)
seniors << Student.new('Jack', 3.45)

upperclassmen = juniors + seniors
p upperclassmen
# <GradeLevel:0x00007f2e31a0cf60 @name="New Group", 
# @members=[#<Student:0x00007f2e31a0d5f0 @name="Jon", @gpa=3.9>, 
            #<Student:0x00007f2e31a0d4b0 @name="Rory", @gpa=3.91>, 
            #<Student:0x00007f2e31a0d438 @name="Phil", @gpa=3.75>, 
            #<Student:0x00007f2e31a0d258 @name="Jordan", @gpa=3.25>, 
            #<Student:0x00007f2e31a0d190 @name="Ernie", @gpa=3.45>, 
            #<Student:0x00007f2e31a0d0f0 @name="Jack", @gpa=3.45>]>
```

The code above relies on the same classes `Gradelevel` and `Student` from above. We further define a custom `GradeLevel#+` method so that we can combine two `GradeLevel` instances according to the pattern set up by `+` in the Ruby docs. Our implementation of `GradeLevel#+` initializes a new `GradeLevel` object to return, this will hold all the members of both the calling `Gradelevel` object, `juniors` and the argument passed, the `GradeLevel` object `seniors`.

We then utilize the `members` getter method to access the arrays fo students that represent the memebers of each `GradeLevel` object, and use `Array#+` to concatentate both. Returning the newly generated `GradeLevel` object allows us to complete implementation, and now when we call `+` on a `GradeLevel` instance, we will get a new `GradeLevel` value returned. This can be shown when we output the resul of `upperclassmen.inspect` (with `p`), which prints a string representation of the new `GradeLevel` objects, whose instance variable `@members` now points ot an array containing all the `Student` objects from teh `juniors` `GradeLevel` object and the `seniors` `GradeLevel` object.

### Element Setters and Getters ###

If we are working with a class that represents a collection, we can also custom define element getter and setter methods. This allows us ot take advantage of Ruby's syntactical sugar with regards to the element reference and reassignment.

Actual Method Call | Syntactical Sugar
------------------ | -----------------
`array.[](2)` | `array[2]`
array.[]=(4, 'fifth_element') | `array[4] = 'fifth_element'`

In our `GradeLevel` example class, we have defined instance variable `@members` as an array of collaboration `Student` objects. Therefore, we can define custom element setter and getter methods for `@members` that allow us to modify the collection via Ruby's syntactical sugar. Our implementation will rely on `Array#[]` and `Array#[]=`.

```ruby
class Gradelevel
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(student)
    members.push student
  end

  def +(other_grade)
    result_group = Gradelevel.new('New Group')
    result_group.members = members + other_grade.members
    result_group
  end

  def [](index)
    # returns the element from @members at the specified index
    members[index]
  end

  def []=(index, object)
    # reassign the element from @members at the specified index to the object
    # passed as argument
    members[index] = object
  end
end

# define Student class for collaborator objects
class Student
  attr_accessor :name, :gpa

  def initialize(name, gpa)
    @name = name
    @gpa = gpa
  end
end

juniors = Gradelevel.new('Juniors')
juniors << Student.new('Jon', 3.9)
juniors << Student.new('Rory', 3.91)
juniors << Student.new('Phil', 3.75)

p juniors[2]    ##<Student:0x00007f901f524e08 @name="Phil", @gpa=3.75>

juniors[2] = Student.new('Angel', 2.75)
p juniors[2]    ##<Student:0x00007f901f524958 @name="Angel", @gpa=2.75>
```
