class Animal
end

class Cat < Animal
end

class Bird < Animalw
end

cat1 = Cat.new
p cat1.color
p cat1.class.ancestors