require 'pry-byebug'
class Move
  MOVES = %w(rock paper scissors lizard spock)

  def initialize(value)
    @value = value
  end

  def >(other_move)
    defeats.include?(other_move.value)
  end

  def <(other_move)
    other_move.defeats.include?(value)
  end

  def to_s
    @value
  end

  protected

  attr_reader :value, :defeats
end

class Rock < Move
  def initialize
    @value = 'rock'
    @defeats = %w(lizard scissors)
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @defeats = %w(rock spock)
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @defeats = %w(paper lizard)
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @defeats = %w(paper spock)
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @defeats = %w(rock scissors)
  end
end

class Player
  attr_accessor :move, :name, :reason

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What is your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::MOVES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move =
      case choice
      when 'rock'     then Rock.new
      when 'paper'    then Paper.new
      when 'scissors' then Scissors.new
      when 'lizard'   then Lizard.new
      when 'spock'    then Spock.new
      end
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'HAL', 'Chappie', 'Android 17'].sample
  end

  def choose
    random_choice = Move::MOVES.sample
    self.move =
      case random_choice
      when 'rock'     then Rock.new
      when 'paper'    then Paper.new
      when 'scissors' then Scissors.new
      when 'lizard'   then Lizard.new
      when 'spock'    then Spock.new
      end
  end
end

class Score
  WINNING_SCORE = 5

  def initialize
    reset
  end

  def reset
    @human = 0
    @computer = 0
  end

  def increment(player)
    self.human += 1 if player == :human
    self.computer += 1 if player == :computer
  end

  def game_over?
    human == WINNING_SCORE || computer == WINNING_SCORE
  end

  def game_winner
    human == WINNING_SCORE ? :human : :computer
  end

  def to_s
    "Score ==> You: #{human}, Computer: #{computer}"
  end

  private

  attr_accessor :human, :computer
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer
  attr_reader :score

  def initialize
    system "clear"
    @human = Human.new
    @computer = Computer.new
    @score = Score.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "We'll play this tourney style:"
    puts "First to #{Score::WINNING_SCORE} wins."
    puts "Press any key to continue..."
    gets
    system "clear"
  end

  def display_goodbye_message
    puts "Thank you for playing Rock, Paper, Scissors, Lizard, Spock."
    puts "Don't cry because it's over, smile because it happened."
    puts "Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    sleep 1
  end

  def display_score
    puts score
  end

  def human_won?
    human.move > computer.move
  end

  def computer_won?
    human.move < computer.move
  end

  def update_score
    if human_won?
      score.increment(:human)
    elsif computer_won?
      score.increment(:computer)
    end
  end

  def display_round_winner
    if human_won?
      puts "#{human.name} won!"
    elsif computer_won?
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
    sleep 1.5
    system "clear"
  end

  def display_game_winner
    winner = score.game_winner == :human ? human.name : computer.name
    puts "#{winner} won the tourney!"
    puts score
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if %w(y n).include? answer.downcase
      puts "Sorry, must be y or n."
    end

    answer.downcase == 'y'
  end

  def play_tourney
    display_welcome_message
    play_game
    display_goodbye_message
  end

  def play_game
    loop do
      system 'clear'
      score.reset
      play
      display_game_winner
      break unless play_again?
    end
  end

  def play
    loop do
      display_score
      play_round
      break if score.game_over?
    end
  end

  def play_round
    human.choose
    computer.choose
    display_moves
    display_round_winner
    update_score
  end
end

RPSGame.new.play_tourney
