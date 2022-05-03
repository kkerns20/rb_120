# Inheritance #

**Inheritance**
: describes how a class can inherit the behaviors of a superclass, or parent class. This allows us to define basic classes with *large reusability* and smaller *subclasses* for more fine-tuned detailed behaviors.

**Superclass*
: the parent clasws for a subclass. Contains the more common behaviors for a set of subclasses that may share that behavior.

**Subclass**
: the class that inherits from a superclass. In Ruby, all classes are in faact subclasses of the `BasicObject` class.

## Class Inheritance ##

We can use the `<` symbol with a class name to cause a class definition to inherit from any given superclass.

```ruby
class Dog
  def speak
    puts "Ruff!"
  end
end

class Poodle < Dog; end
class Weimaraner < Dog; end
class YorkshireTerrier < Dog; end

# all of the Dog subclasses inherit behavior from the Dog superclass
max = Poodle.new
kirree = Weimaraner.new
albie = YorkshireTerrier.new

max.speak       # => Ruff!
kirree.speak    # => Ruff!
albie.speak     # => Ruff!
```

In the code above, we define a `Dog` superclass with the behavior `#speak`. All subclasses (`Poodle`, `Weimaraner`, `YorkshireTerrier`) inherit this behavior. This makes inheritance an excellent tool for getting rid of duplicate code, giving us a means to extract repeated logic into one place for reuse.

We can define our own custom methods within a subclass to **override** and inherited methods of the same name. Ruby looks for method definitions from the closest possible area on outward; therefore, it will encounter any methods defined in the subclass first and execute the implementation it finds there. If the method name in question is not found, it will continue to look upwards in the chain of superclasses until it find what it is looking for.
