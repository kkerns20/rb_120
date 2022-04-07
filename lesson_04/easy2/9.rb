class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    "Eyes down"
  end
end

# IF we added a `play` method to the `Bingo` class...
# it would override the superclass and only execute the 
# `play` method from within the `Bingo` class

game_of_bingo = Bingo.new
p game_of_bingo.play
# "Eyes down"