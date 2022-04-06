require 'io/console'

module Printable
  @@rows, @@columns = IO.console.winsize  
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

  @@move_history = Hash.new([])
  
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

  def self.move_history
    @@move_history
  end

  def self.reset_move_history
    @@move_history = Hash.new([])
  end

  def self.history
    player1, player2 = @@move_history.keys
    column_headings = "Round".center(@@columns) +
                      player1.center(@@columns) +
                      player2.center(@@columns)
    history = ["MOVE_HISTORY", '', column_headings, '']

    (0...@move_history[player1].size).each do |i|
      row = "(#{i + 1}".center(@@columns) +
            @@move_history[player1][1].to_s.center(@@columns) +
            @@move_history[player2][1].to_s.center(@@columns)
      history << row
    end

    history
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

  private

  def save_move
    Move.move_history[name] += [move.to_s]
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

    self.move = choice
    save_move
  end
end