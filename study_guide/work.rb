class Animal
  def eats
    puts "feeds on living things"
  end
end

class Carnivore < Animal
  def eats
    puts "feeds on meat"
  end
end

class Herbivore < Animal
  def eats
    puts "feeds on plants"
  end
end

class Omnivore < Animal; end

lion = Carnivore.new
rabbit = Herbivore.new
person = Omnivore.new

animals = [lion, rabbit, person]
animals.each { |animal| animal.eats }
# => feeds on meat
# => feeds on plants
# => feeds on living things