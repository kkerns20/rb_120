=begin
2. What is a module? What is its purpose?
How do we use them with our classes? 
Create a module for the clsas you created in exercise 1 and include it properly

A module is a collection of behaviors that are usable in other classes via **mixins**. 
It allows us to use behaviors that can be used by multiple differenct classes. 
Any class could have access to the trees instance method if they mixed-in 
Foliage through the `include` method within their class definition

A module is a way that Ruby can implement polymorphism. It is a collection
of defined methods (behaviors) that can be applied to objects of multiple
types (classes). A module is "mixed-in" to a class declaration using the 
`include` classe method
=end

module Foliage
  def trees
    puts "We planted a tree!"
  end
end

class Creation
  include Foliage
end

the_world = Creation.new
p the_world.class
the_world.trees
  