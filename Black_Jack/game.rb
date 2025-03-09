class Game

  BET = 10

  def initialize
    #@user = User.new
    #@dealer = Dealer.new
    #@deck = Deck.new
    @decks = []
  end
  
  def create_game
    puts "Приветствуем Вас в игре Black Jack"
    puts "Как Вас зовут?"
    name = gets.chomp
    @user = User.new(name)
    @dealer = Dealer.new("dealer")
    start_game
  end  

  def start_game
    create_deck
    place_bet
    deal_cards(2)
    #play_round
    #define_winner
  end
  
  def create_deck
    @deck = CardDeck.new
    @decks << @deck
  end

  def deal_cards(count)
    count.times do
      @user.take_card(@deck)
      @dealer.take_card(@deck)
    end 
  end  

  def place_bet
    @user.put_bank(BET)
    @diller.put_bank(BET)
    @bank = BET + BET
  end
  
  def play_round
    @user.make_move_1
    @dealer.make_move_1
    @user.make_move_2
    @dealer.make_move_2
  end
  
  def define_winner
    if user.points < dealer.points
      dealer
    else
      user
    end
  end      
end
 


 
 
  
  