class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# In the `make_one_year_older` method we have used `self`
# write this method so we don't have to use the `self` prefix

# since we have the setter method from `attr_accessor`, we can 
# replace `self` with `#`

# `self` is referncing the setter method provided by `attr_accessor`

# alternate method logice
def make_one_year_older
  @age += 1
end
