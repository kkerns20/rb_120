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

# What does `self` refer to here?
# `make_one_year_older` is an instance method and can only
# only be called on instances of the Cat class, so `self` here
# is referencing the instance (object) that called the method
# - the calling object