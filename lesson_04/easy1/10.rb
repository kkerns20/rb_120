class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
# You would need to intiatiate an object of the `Bag` class
# with two arguments
sports_bag = Bag.new('black', 'polyester')