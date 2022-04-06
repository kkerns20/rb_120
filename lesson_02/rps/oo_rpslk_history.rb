require 'io/console'

module Printable
  def clear_screen
    system("clear") || system("cls")
  end

  def print_message(message)
    message.each { |line| puts "#{line}" }
  end
end

class Move
  include Printable
  
  VALUES = %w(rock paper scissors lizard spock)
  
  attr_reader :beats, :value

  def initiailize(value)
    @value = value
    @beats = []
  end

  def to_s
    @value
  end
  
  def beats?(other_move)
    beats.include?(other_move.value)
  end

  def self.return_subclass_instance(choice)
    Move::VALUES.each do |value|
      if choice == value
        return const_get(value.capitalize).new
      end
    end
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @beats = ['lizard', 'scissors']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @beats = ['rock', 'spock']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @beats = ['paper', 'lizard']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @beats = ['spock', 'paper']
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @beats = ['rock', 'scissors']
  end
end

class Player
  attr_accessor :move, :score, :name

  def initialize
    @name = ''
    @move = nil
    @score = 0
  end

  def reset_score
    @score = 0
  end
end

class Human < Player
  include Printable
  
  def initialize
    super
  end

  def set_name
    n = ''
    loop do
      print_message ["What's your name?"]
      n = gets.chomp
      break unless n.empty?
      print_message ["Must enter a name."]
    end

    self.name = n
  end

  def choose
    choice = nil
    loop do
      print_message ["Please make a choice: " \
                    "rock, paper, scissors, lizard, or spock:"]
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      print_message ["Invalid choice."]
    end

    self.move = Move.return_subclass_instance(choice)
  end
end

class Computer < Player
  attr_reader :move_percentages

  def initialize
    super
    @name = self.class.to_s
    @move_percentages = { 'rock' => 20, 'paper' => 20, 'scissors' => 20,
                          'lizard' => 20, 'spock' => 20 }
  end

  def choose
    self.move = Move.return_subclass_instance(weighted_choice)
  end

  private

  def weighted_choice
    list_of_choices = []
    move_percentages.each do |move, percent|
      percent.times { list_of_choices << move }
    end

    list_of_choices.sample
  end
end

class Hal < Computer
  def initialize
    super
    @move_percentages = { 'rock' => 25, 'paper' => 15, 'scissors' => 20,
                          'lizard' => 10, 'spock' => 30 }
  end
end

class Android18 < Computer
  def initialize
    super
    @move_percentages = { 'rock' => 20, 'paper' => 15, 'scissors' => 15,
                          'lizard' => 20, 'spock' => 20 }
  end
end

class Skynet < Computer
  def initialize
    super
    @move_percentages = { 'rock' => 30, 'paper' => 20, 'scissors' => 15,
                          'lizard' => 10, 'spock' => 15 }
  end
end

class C3PO < Computer
  def initialize
    super
    @move_percentages = { 'rock' => 15, 'paper' => 30, 'scissors' => 15,
                          'lizard' => 20, 'spock' => 10 }
  end
end

class Android17 < Computer
  def initialize
    super
    @move_percentages = { 'rock' => 15, 'paper' => 30, 'scissors' => 15,
                          'lizard' => 20, 'spock' => 10 }
  end
end

class MoveRecord
  def initialize(game, round, player, player_move, computer, computer_move, score)
    @game = game
    @round = round
    @player = player
    @player_move = player_move
    @computer = computer
    @computer_move = computer_move
    @score = round_score
  end

  def display
    puts "Game #{game}, Round #{round}. #{score}"
    puts "#{player} played #{player_move}. #{computer} player #{computer_move}."
  end

  private

  attr_reader :game, :round, :player, :player_move, :computer, :computer_move, :score
end

class History
  def initialize
    @history = []
  end

  def add_move(move_record)
    history << move_record
  end

  def display
    puts "Game History"
    puts "------------------------"
    history.each do |move_record|
      move_record.display
    end
  end

  private

  attr_reader :history
end

class RPSGame
  include Printable

  attr_accessor :human, :computer, :game_num, :round_num
  attr_reader :score, :game_history

  MAX_SCORE = 3
  OPPONENTS = [Hal.new, Android18.new, Skynet.new, Android17.new, C3PO.new]

  def initialize
    clear_screen
    @human = Human.new
    @computer = OPPONENTS.sample
    @game_history = History.new
    @game_num = 1
    @round_num = 1
  end

  def play
    loop do
      set_up_game
      loop do
        play_single_match
        break if game_won? || !(play_again?)
        clear_screen
      end
      display_history
      break unless play_again?
      reset_tournament
    end
    end_game
  end

  private

  def set_up_game
    print_message(welcome_message)
    gets
    human.set_name
    clear_screen
  end

  def play_single_match
    human.choose
    computer.choose
    update_scores!
    show_winner
    advance_game
    advance_round
    sleep 1.5
  end

  def update_scores!
    human.score += 1 if human.move.beats?(computer.move)
    computer.score += 1 if computer.move.beats?(human.move)
  end

  def store_history
    move_record = MoveRecord.new(
      game = game_num,
      round = round_num,
      player = human,
      player_move = human.move,
      computer_player = computer,
      computer_player_move = computer.move,
      round_score = score.clone,
    )
    game_history.add_move(move_record)
  end

  def display_history
    game_history.display
  end

  def advance_round
    self.round_num += 1
  end

  def advance_game
    self.game_num += 1
  end

  def show_winner
    print_message(moves_message)
    sleep 0.5
    print_message(winner_message)
    sleep 1.5
  end

  def game_won?
    human.score == MAX_SCORE || computer.score == MAX_SCORE
  end

  def play_again?
    answer = nil
    loop do
      print_message ["Would you like to play again? (y/n)"]
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      print_message ["Invalid choice, please enter 'y' or 'n'"]
    end
    answer == 'y'
  end


  def reset_tournament
    human.reset_score
    computer.reset_score
  end

  def end_game
    print_message(goodbye_message)
    sleep 2
    clear_screen
  end

  def welcome_message
    ["Welcome to Rock, Paper, Scissors, Lizard, Spock!", "",
     "Scissors cuts Paper covers Rock crushes",
     "Lizard poisons Spock smashes Scissors",
     "decapitates Lizard eats Paper disproves",
     "Spock vaporizes Rock crushes Scissors", "",
     "The first player to win #{MAX_SCORE} games wins!",
     "Press any key to continue..."]
  end

  def moves_message
    ["#{human.name} chose #{human.move}",
     "#{computer.name} chose #{computer.move}"]
  end

  def winner_message
    message = ["", "The current score:", "#{human.name} - #{human.score}",
               "#{computer.name} - #{computer.score}"]
    message.prepend(winner_result)
    message
  end

  def winner_result
    if human.move.beats?(computer.move)
      "#{human.name} won!"
    elsif computer.move.beats?(human.move)
      "#{computer.name} won!"
    else
      "It's a tie!"
    end
  end

  def final_winner_message
    message = ["", "FINAL SCORE", "", "#{human.name} - #{human.score}",
               "#{computer.name} - #{computer.score}", ""]
    message << final_winner_result
    message
  end

  def final_winner_result
    if human.score > computer.score
      "~*~  #{human.name} is the ultimate champion!!  ~*~"
    elsif computer.score > human.score
      "~*~  #{computer.name} is the ultimate champion!!  ~*~"
    else
      "~*~  It's a tie!  ~*~"
    end
  end

  def goodbye_message
    ["Thanks for playing! Goodbye!"]
  end
end

RPSGame.new.play