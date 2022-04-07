class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# What is needed for `Bingo` to inherit `Game`?
# `<` Game class
# to test, initiate an object of Bingo and call `play`
game_of_bingo = Bingo.new
p game_of_bingo.play
# => "Start the game!"