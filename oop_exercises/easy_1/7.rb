class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total      # or @mileage = total
    # initially it was creating a new local variable
    # we either needed access to the setter method OR
    # refer to the instance variable directly
    # it's generally safer to use an explicit `self.` caller when
    # you have a setter method unless there's a good reason to use the instance
    # variable directly.

    # def mileage=(miles)
      # @mileage = miles.to_i
    # end
    # this type of setter method will guarantee the application of `to_i` to the value
    # if you didn't use the setter, we may try to set mileage to a string value
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678