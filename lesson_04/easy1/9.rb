class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  # Using self here denotes a class method, so to call it, 
  # you would use `Cat.cats_count`
  def self.cats_count
    @@cats_count
  end
end