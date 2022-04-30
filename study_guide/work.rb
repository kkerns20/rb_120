class Superhero
  def initialize(n)
    @name = n         # intialize @name
  end

  def name
    @name             # define getter method name
  end

  def introduce       # access @name through getter method #name
    puts "Sup? It's your friendly neighborhood #{name}!"
  end
end

spider_man = Superhero.new("Spider-Man")
spider_man.name             # => Spider-Man
spider_man.introduce        # => Sup? It's your friendly, neighborhood Spider-Man!