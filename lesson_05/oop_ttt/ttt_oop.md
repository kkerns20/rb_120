# OO Tic Tac Toe

## Object Oriented Design Approach

  1. Write a description of the problem and extract major nouns and verbs.
  2. Make an initial guess at organizing the verbs into nouns and do a spike to explore the problem with temporary code.
  3. Optional - when you have a better idea of the problem, model your thoughts into CRC cards.

## Nouns and Verbs

***Description of game***

> Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns marking a square. The first player to mark 3 squares in a row wins.

On the surface, Tic Tac Toe is a very simple game, without too many nouns:

*Nouns*
: board, player, square, grid

*Verbs*
: play, mark

Organized:

- Board
- Square
- Player
  - mark
  - play

## Spike

```ruby
class Board
  def initialize
    # we need some way to model the 3x3 grid. Maybe "squares"?
    # what data structure should we use?
    # - array/hash of Square objects?
    # - array/hash of strings or integers?
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of this square's mark?
  end
end

class Player
  def initialize
    # maybe a "marker" to keep track of this player's symbol (ie, 'X' or 'O')
  end

  def mark

  end

  def play

  end
end

# Game Orchestration Engine
class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
```
