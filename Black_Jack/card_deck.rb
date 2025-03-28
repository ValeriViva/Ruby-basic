# frozen_string_literal: true

class CardDeck
  SUITS = ['♠️', '♥️', '♦️', '♣️'].freeze
  VALUES = %w[Т К Д В 10 9 8 7 6 5 4 3 2].freeze
  POINTS = { 'Т' => 11, 'К' => 10, 'Д' => 10, 'В' => 10, '10' => 10, '9' => 9, '8' => 8, '7' => 7, '6' => 6, '5' => 5, '4' => 4,
             '3' => 3, '2' => 2 }.freeze

  attr_reader :cards

  def initialize
    @cards = []
    generate_deck
  end

  def deal_card
    generate_deck if @cards.empty?
    @cards.delete(@cards.sample)
  end

  private

  def generate_deck
    SUITS.each do |suit|
      VALUES.each do |value|
        card = Card.new(suit, value, POINTS[value])
        @cards << card
      end
    end
  end
end
