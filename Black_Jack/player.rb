class Player
  attr_accessor :cards, :bank, :name, :points

  def initialize(name)
    @bank = 100;
    @cards = []
    @points = 0
    @name = name
  end

  def place_bet(bet)
    @bank -= bet
  end 
  
  def take_card(deck)
    @cards << deck.deal_card
  end
  
  def show_cards
    puts "#{@name}, Ваши карты:"
    @cards.each { |card| puts "#{value}#{suit}"}
  end

  def get_points
    cards.each do |card|
      if card.value == 'Т'
        @points += @points + 11 <= 21 ? 11 : 1
      else 
        @points += card.point
      end
    end
  end
  
  def show_points
    puts "#{@name}, у Вас #{@points} очков"
  end  

end  