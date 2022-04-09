require 'io/console'
require 'pry-byebug'

module Printable
  SUIT_SYMBOLS = "\u2660 \u2663 \u2665 \u2666"
  @@rows, @@columns = IO.console.winsize

  def clear
    system 'clear'
  end

  def print_centered(message)
    puts message.center(@@columns)
  end

  def print_empty_line
    puts ''
  end
end

class Deck
  SUITS= %w(H D S C)
  RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  attr_accessor :cards

  def initialize
    @cards = []
    SUITS.each do |s|
      RANKS.each do |r|
        @cards << Card.new(s, r)
      end
    end
  end

  def deal_single_card!
    @cards.shuffle!.pop
  end
end

class Card
  extend Printable

  HIDDEN_CARD = [" ___ ",
                 "|*  |",
                 "| * |",
                 "|__*|"]
  @@card_rows = [[], [], [], []]

  attr_reader :suit, :rank
  attr_accessor :points

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @points = calculate_points
  end

  def to_s
    "#{rank} #{suit_symbol}"
  end

  def display_hidden
    (0..3).each { |index| @@card_rows[index] << HIDDEN_CARD[index] }
  end
  
  def display_visible
    @@card_rows[0] << " ___ "
    if rank == '10'
      @@card_rows[1] << "#{rank}  |"
      @@card_rows[2] << "| #{suit_symbol} |"
      @@card_rows[3] << "|__#{rank}"
    else
      @@card_rows[1] << "|#{rank}  |"
      @@card_rows[2] << "| #{suit_symbol} |"
      @@card_rows[3] << "|__#{rank}|"
    end
  end

  def self.reset_card_rows
    @@card_rows = [[], [], [], []]
  end

  def self.display_full_hand
    @@card_rows.each { |row| print_centered(row.join(' ')) }
    Card.reset_card_rows
  end

  private

  def calculate_points
    if numbered_card?
      rank.to_i
    elsif face_card?
      10
    else
      11
    end
  end

  def numbered_card?
    !('A'..'Z').include?(rank)
  end

  def face_card?
    %w(J Q K).include?(rank)
  end

  def suit_symbol
    case suit
    when 'S' then "\u2660"
    when 'C' then "\u2663"
    when 'H' then "\u2665"
    when 'D' then "\u2666"
    else          suit
    end
  end
end

class Gambler
  include Printable

  attr_accessor :hand, :name, :score
  attr_reader :total

  def initialize
    @hand = []
    @score = 0
    set_name
  end

  def hit(card)
    hand << card
    calculate_total
  end

  def busted?
    total > TwentyOneGame::POINTS_UPPER_LIMIT
  end

  def calculate_total
    self.total = 0
    hand.each { |card| self.total += card.points }
    correct_for_aces
  end

  def display_hand
    print_centered "======> #{name} <======"
    hand.each(&:display_visible)
    Card.display_full_hand
    print_empty_line
    print_centered "Hand Total: #{total}"
    print_empty_line
  end

  private

  attr_writer :total

  def correct_for_aces
    hand.count { |card| card.rank == 'A' }.times do
      self.total -= 10 if busted?
    end
  end
end

class Dealer < Gambler
  DEALER_STAYS = 17
  DEALERS = ['Android 17', 'Baymax', 'R2-D2', 'BB-8', 'David-8']

  def set_name
    self.name = DEALERS.sample
  end

  def display_hidden_hand
    print_centered "======> #{name} <======"
    hand.each_with_index do |card, index|
      if index == 0
        card.display_hidden
      else
        card.display_visible
      end
    end
    Card.display_full_hand
    print_empty_line
  end
end

class Player < Gambler
  def ask_move
    answer = nil
    print_centered "Would you like to (h)it or (s)tay?"
    loop do
      answer = gets.chomp.downcase
      break if %w(h s).include? answer
      print_centered "Please enter 'h' or 's'."
    end

    answer
  end

  def set_name
    print_centered "What is your Gambling ID?"
    loop do
      self.name = gets.chomp.capitalize
      break if !name.empty?
      print_centered "Please enter an ID."
    end
  end
end

class TwentyOneGame
  include Printable

  POINTS_UPPER_LIMIT = 21
  ROUNDS_TO_WIN = 5

  attr_accessor :deck
  attr_reader :dealer, :player

  def initialize
    clear
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def play
    display_welcome
    loop do
      play_single_round
      display_grand_winner
      break unless play_again?
      reset_tourney
    end
    display_goodbye
  end

  private

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def display_welcome
    clear
    print_centered SUIT_SYMBOLS
    print_empty_line
    print_centered "Hi #{player.name}!"
    print_centered "Welcome to #{POINTS_UPPER_LIMIT}!"
    print_empty_line
    print_centered "Get as close to #{POINTS_UPPER_LIMIT} as possible, "\
         "without going over."
    print_centered "Cards 2-10 are each worth their face value."
    print_centered "Jacks, Queens, and Kings are all worth 10."
    print_centered "An Ace can be worth either 11 or 1."
    print_empty_line
    print_centered "Tell the dealer 'hit' to get another card."
    print_centered "Choose to 'stay' to try your luck with what you've got."
    print_centered "If you go over #{POINTS_UPPER_LIMIT} you 'bust' and" \
    " the dealer wins!"
    print_empty_line
    print_centered "Your dealer today will be #{dealer.name}."
    print_centered "The first player to win #{ROUNDS_TO_WIN} games wins!"
    print_empty_line
    print_centered SUIT_SYMBOLS
    print_empty_line
    print_centered "Hit enter to begin. Good luck!"
    gets
  end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

# rubocop:disable Metrics/MethodLength
  def play_single_round
    loop do
      clear
      deal_initial_cards
      show_hidden_cards
      turn_cycle
      show_all_cards
      update_score
      show_result
      break if someone_won_tourney?
      quit_early unless play_again?
      reset
    end
  end
# rubocop:enable Metrics/MethodLength

  def deal_initial_cards
    2.times do
      dealer.hand << deck.deal_single_card!
      player.hand << deck.deal_single_card!
    end
    dealer.calculate_total
    player.calculate_total
  end

  def show_hidden_cards
    print_centered "===> SCORE <==="
    print_empty_line
    print_centered "#{player.name} - #{player.score} " \
      "| #{dealer.name} - #{dealer.score}"
    print_empty_line
    dealer.display_hidden_hand
    player.display_hand
    print_empty_line
  end

  def show_all_cards
    print_centered "===> SCORE <==="
    print_empty_line
    print_centered "#{player.name} - #{player.score} " \
      "| #{dealer.name} - #{dealer.score}"
    print_empty_line
    dealer.display_hand
    player.display_hand
    print_empty_line
  end

  def turn_cycle
    player_turn
    dealer_turn unless player.busted?
  end

  def player_turn
    loop do
      break if player.busted?
      case player.ask_move
      when 'h' then player.hit(deck.deal_single_card!)
      when 's' then break
      end
      clear
      show_hidden_cards
    end
    print_centered "BUST!!!" if player.busted?
  end
  
  def dealer_turn
    while dealer.total < Dealer::DEALER_STAYS
      sleep 0.5
      dealer.hit(deck.deal_single_card!)
      clear
      show_all_cards
      sleep 1
      if dealer.busted?
        print_centered "#{dealer.name.upcase} BUSTS!!!"
        break
      end
    end
  end

# rubocop:disable Metrics/MethodLength
  def find_winner
    if player.busted?
      dealer
    elsif dealer.busted?
      player
    elsif dealer.total > player.total
      dealer
    elsif player.total > dealer.total
      player
    else
      :tie
    end
  end
# rubocop:enable Metrics/MethodLength

  def update_score
    case find_winner
    when dealer then dealer.score += 1
    when player then player.score += 1
    end
  end

  def show_result
    print_empty_line
    if player.busted? || dealer.busted?
      show_busted_result
    else
      show_stay_result
    end
    print_empty_line
    print_centered "The score is now: #{player.name} - #{player.score} " \
      "| #{dealer.name} - #{dealer.score}"
    print_empty_line
  end

  def show_stay_result
    print_centered "Both players have stayed."
    print_empty_line
    print_centered "#{player.name} has #{player.total} " \
      "| #{dealer.name} has #{dealer.total}"
    display_winner
  end

  def show_busted_result
    if player.busted?
      print_centered "#{player.name} busted! #{dealer.name} wins!"
    else
      print_centered "#{dealer.name} busted! #{player.name} wins!"
    end
  end

  def display_winner
    case find_winner
    when player then print_centered "#{player.name} wins!"
    when dealer then print_centered "#{dealer.name} wins!"
    else             print_centered "It's a tie!"
    end
  end

  def someone_won_tourney?
    player.score >= ROUNDS_TO_WIN || dealer.score >= ROUNDS_TO_WIN
  end

  def display_grand_winner
    print_empty_line
    if player.score > dealer.score
      print_centered "#{player.name} is the grand winner!"
    else
      print_centered "#{dealer.name} is the grand winner!"
    end
    print_empty_line
  end

  def play_again?
    answer = nil
    print_centered "Would you like to gamble some more? (y/n)"
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      print_centered "Please enter 'y' or 'n'"
    end

    answer == 'y'
  end

  def reset
    self.deck = Deck.new
    player.hand = []
    dealer.hand = []
  end

  def reset_tourney
    reset
    player.score = 0
    dealer.score = 0
  end

  def display_goodbye
    print_centered "Thank you for playing #{POINTS_UPPER_LIMIT}! Goodbye!"
    sleep 2
    clear
  end

  def quit_early
    display_goodbye
    sleep 2
    clear
    exit
  end
end

TwentyOneGame.new.play

