# We need a new class Noble that shows the title and name when walk is called:
# byron = Noble.new("Byron", "Lord")
# p byron.walk
# => "Lord Byron struts forward"

# You must also access both name and title for other purposes not shown
module Walkable
  def walk
    "#{full_name} #{gait} forward"
  end
end

class Animal
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def full_name
    name
  end
end

class Person < Animal
  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :title

  def initialize(name, title)
    super(name)
    @title = title
  end

  private

  def full_name
    "#{title} #{name}"
  end

  def gait
    "struts"
  end
end

class Cat < Animal
  private

  def gait
    "saunters"
  end
end

class Cheetah < Cat
  private

  def gait
    "runs"
  end
end


mike = Person.new("Mike")
puts mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
puts kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
puts flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"
p byron.name
p byron.title