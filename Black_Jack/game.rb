class Game

  BET = 10

  def initialize
    #@user = User.new
    #@dealer = Dealer.new
    #@deck = Deck.new
    @decks = []
    @bank = 0
  end
  
  def create_game
    puts "Приветствуем Вас в игре Black Jack"
    puts "Как Вас зовут?"
    name = gets.chomp.capitalize
    @user = User.new(name)   #заменить на Player.new
    @dealer = Dealer.new("dealer") #заменить на Player.new
    start_game
  end  

  def start_game
    create_deck
    place_bet
    deal_cards(2)
    @user.show_cards
    puts "Карты дилера: * *"
    scoring
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
  
  def scoring
    @user.get_points
    puts "#{@user.name}, у Вас #{@user.points} очков"
    user_move
  end  

  def user_move
    puts "Ваш ход - выберите действие:"
    action = { a: method(:scip(@user)), b: method(:add_card(@user)), c: method(:open_cards) }
    loop do
      puts "Пропустить ход - a\n
            Добавить карту - b\n
            Открыть карты - c"
      choice = gets.chomp.to_sym
      action.key?(choice) ? action[choice].call : incorrect_input
    end
  end
  
  def scip(player)
    if player == @user 
      dealer_move
    else
      user_move
    end
  end  

  def dealer_move
    if @diller.points >= 17 || @diller.cards.size > 2 
      scip(@diller)
    else
      add_card(@diller)
      user_move
    end
  end

  def add_card(player)
    if player == @user && @user.cards.size < 3
      @user.take_card(@deck)
      @user.show_cards
    else  
      @dealer.take_card(@deck)
      puts "Карты дилера: * * *"
    end  
  end    

  def open_cards
    @user.show_cards 
    @dealer.show_cards
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
  
  def incorrect_input
    puts 'Введено неверное значение'
  end
end
 


 
 
  
  