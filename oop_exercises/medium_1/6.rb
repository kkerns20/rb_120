=begin
- Create an oop game for guessing a number from 1 to 100
  - limit 7 guesses per game
# Gameplay
game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!

# Algo
initialize class Guess
- use constructor
  - set guess limit to Math.log2(size_of_range).to_i + 1
  - set number range to from intiailization input
  - instance variable of guesses remaining to guess limit
  - secretu number to a random number from the integer range
  - initialize guess
- display the number of guesses remianing
- ask the user to enter a number from 1 to 100
  - validate the number (must be within the number range)
- explain if guess is too high or too low
- if user guesses the number, display winning message
- if user is out of guess, display losing message
- decrement guesses after each guess
=end

class Guess
  def initialize(lower_limit, upper_limit)
    @number_range = lower_limit..upper_limit
    @guesses = Math.log2(upper_limit - lower_limit).to_i + 1
    @secret_number = rand(@number_range)
    @guess
  end

  attr_accessor :guess, :guesses
  attr_reader :secret_number, :number_range

  def play
    clear
    loop do
      show_remaining_guesses
      self.guess = ask_valid_number
      break if number_guessed?
      show_low_high
      self.guesses -= 1
      break if out_of_guesses?
    end
    show_results
  end

  private

  def clear
    system 'clear'
  end

  def show_remaining_guesses
    if guesses == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{guesses} guesses remaining."
    end
  end

  def ask_valid_number
    @guess = ''
    loop do
      print\
        "Enter a number between #{@number_range.first} and #{@number_range.last}: "
      @guess = gets.chomp
      break if valid_guess?
      print "Invalid guess. "
    end
    @guess = @guess.to_i
  end

  def valid_guess?
    @guess == @guess.to_i.to_s &&
    @number_range.include?(@guess.to_i)
  end

  def number_guessed?
    @guess == @secret_number
  end

  def show_low_high
    if @guess > @secret_number
      puts 'Your guess is too high.'
      puts
    else
      puts 'Your guess is too low.'
      puts
    end
  end

  def out_of_guesses?
    @guesses <= 0
  end

  def show_results
    if  number_guessed?
      puts "That's the number!"
      puts
      display_winning_message
    else
      puts
      display_losing_message 
    end
  end

  def display_winning_message
    puts 'You won!'
    puts
    puts "Thanks for playing!"
  end

  def display_losing_message
    puts "You have no more guesses. You lost!"
    puts
    puts "The secret number was #{@secret_number}."
    puts "Thanks for playing!"
  end
end

game = Guess.new(501, 1500)
game.play