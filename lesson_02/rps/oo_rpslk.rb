require 'pry-byebug'
class Move
  CHOICES = {
    rock:     { abbreviation: 'r', defeats: %w(lizard scissors) },
    paper:    { abbreviation: 'p', defeats: %w(rock spock) },
    scissors: { abbreviation: 's', defeats: %w(lizard paper) },
    lizard:   { abbreviation: 'l', defeats: %w(spock paper) },
    spock:    { abbreviation: 'k', defeats: %w(rock scissors) }
  }
  VALUES = CHOICES.keys.map(&:to_s)

  def initialize(value)
    @value = value
  end

  def >(other_move)
    CHOICES[@value.to_sym][:defeats].include?(other_move.value)
  end

  def <(other_move)
    CHOICES[other_move.value.to_sym][:defeats].include?(@value)
  end

  def to_s
    @value
  end

  protected

  attr_reader :value
end

class Score
  WINNING_SCORE = 3

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
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Android 17'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
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
    puts "First to #{Score::WINNING_SCORE} wins."
    puts "Press any key to continue..."
    gets
    system "clear"
  end

  def display_goodbye_message
    puts "Thank you for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    sleep 1
  end

  def display_score
    puts score
  end

  def update_score
    if human.move > computer.move
      score.increment(:human)
    elsif human.move < computer.move
      score.increment(:computer)
    end
  end

  def human_won?
    human.move > computer.move
  end

  def computer_won?
    human.move < computer.move
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
    puts "#{winner} won the game!"
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
