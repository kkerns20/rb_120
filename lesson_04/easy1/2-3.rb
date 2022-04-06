=begin 
If we have a Car class and a Truck class and 
we want to be able to go_fast, 
how can we add the ability for them to go_fast using the module Speed?
How can you check if your Car or Truck can now go fast?
=end

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
    # `self` refers to the object itself, in this case either `Car` or `Truck` object
    # We ask `self` to tell us its class with `.class`
    # No need for `to_s` because it is inside a `string` and is interpolated
    
    # by calling self#class, it returns the class of the object that was instantiated
  end
end

class Car
  # mixin the module Speed
  include Speed

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

# after instantiating an object in either class, we call the `go_fast` method
armada = Car.new
armada.go_fast
tundra = Truck.new
tundra.go_fast