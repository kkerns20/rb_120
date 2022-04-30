class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        cards << Card.new(suit, rank)
      end
    end
  
    cards.shuffle!
  end

  def deal_one_card
    cards.pop
  end
end

class Card
  SUITS = %w(Hearts Clubs Diamonds Spades)
  RANKS = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)

  attr_accessor :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "The #{rank} of #{suit}"
  end
end

deck = Deck.new

hand = []

5.times { hand << deck.deal_one_card }

hand.each { |card| puts card }

  # => The Jack of Spades
  # => The Jack of Clubs
  # => The 10 of Clubs
  # => The Ace of Diamonds
  # => The 9 of Diamonds
  # cards are randomly selected, output will differ