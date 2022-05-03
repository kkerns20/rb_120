module Cuddleable
  def can_cuddle
    @cuddles = true
  end
end

class Offspring
  def initialize(name)
    @name = name
  end
end

class FirstBorn < Offspring
  include Cuddleable

  def speak
    puts "Fire trutchs!"
  end

  def cuddle
    if @cuddles
      puts "Tank tu Dadd-dy"
    else
      puts "WAAAAHHHH!!! NOOOO!"
    end
  end
end

rhone = FirstBorn.new('Rhone')

rhone.can_cuddle
rhone.cuddle        # => Tank tu Dadd-dy