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

### equal? and object_id ###

### `Operators#===` ###

### eql? ###

## Fake Operators ##

### Equality Methods ###

### Comparison Methods ###

### Right and Left Shift ###

### The Plus Method ###

### Element Setters and Getters ###
