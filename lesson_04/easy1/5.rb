# which class has an instance variable

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  # this class has an instance variable, denoted by `@name`
  def initialize(name)
    @name = name
  end
end

# We can check by instantiating objects from both classes and ask
# each of the objects if they have instance variables with
# `.instance_variables`

hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

p hot_pizza.instance_variables
# => [:@name]
p orange.instance_variables
# => []