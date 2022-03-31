# ZetCode Ruby OOP Part 1

*Object-oreinted programming (OOP)*
: a programming paradigm that uses objects and their interactions to design applications and computer programs.

The basic programming concepts in OOP are:
  - Abstraction
  - Polymorphism
  - Encapsulation
  - Inheritance

*abstraction*
: simplifying complex reality by modeling classes appropriate to the problem

*polymorphism* 
: the process of using an operator or function in differnt ways for different data input

*encapsulation*
: hides the implementation details of a class from other objects

*inheritance*
: a way to form new classes using classes that have already been defined


## Ruby super method ##

The super method calls a method of the same name in the parent's class. If the method has no arguments it automatically passes all its arguments. If we write super no arguments are passed to parent's method.

```ruby
class Base

  def show x=0, y=0
      p "Base class, x: #{x}, y: #{y}"
  end
end

class Derived < Base

  def show x, y
      super       # passes along all arguments
      super x     # just passes along x argument
      super x, y  # passes along two arguments
      super()     # passes no arguments 
                  # <- must do this is your intent is not arguments to pasee
  end
end


d = Derived.new
d.show 3, 3

=begin
Output:
"Base class, x: 3, y: 3"
"Base class, x: 3, y: 0"
"Base class, x: 3, y: 3"
"Base class, x: 0, y: 0"
  
=end
```