class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greeting
    puts "Hello! My name is #{name}!"    
  end
end

kitty = Cat.new('Sophie')
kitty.greeting
kitty.name = "Luna"
kitty.greeting
