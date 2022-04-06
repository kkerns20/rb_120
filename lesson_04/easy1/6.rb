# what could we add to access the instance varible `@volume`

class Cube
  # adding this 
  attr_reader :volume
  def initialize(volume)
    @volume = volume
  end

# either by adding an getter method
  def get_volume
    @volume
  end
end

=begin
Technically we don't need to add anything at all. 
We are able to access instance variables directly 
from the object by calling instance_variable_get on the instance. 

We could add a specific getter method or attr_reader, 
which will accomplish the same thing


=end

big_cube = Cube.new(5000)
p big_cube.instance_variable_get("@volume")
# => 5000