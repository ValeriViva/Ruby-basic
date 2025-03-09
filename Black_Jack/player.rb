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

end