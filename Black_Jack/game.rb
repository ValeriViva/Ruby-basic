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
    @user = Player.new(name)
    @dealer = Player.new("dealer")
    start_game
  end  

  def start_game
    create_deck
    place_bet
    deal_cards(2)
    @user.show_cards
    puts "Карты дилера: * *"
    scoring_1
    # @user.show_points
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
    @user.place_bet(BET)
    @dealer.place_bet(BET)
    @bank = BET + BET
  end
  
  def scoring_1
    @dealer.get_points
    @user.get_points
    @user.show_points
    #puts "#{@user.name}, у Вас #{@user.points} очков"
    user_move
  end  

  def user_move
    if @user.cards.size == 3 && @dealer.cards.size == 3
      open_cards
    else  
      puts "Ваш ход - выберите действие:"
      user_move = { a: method(:scip), b: method(:add_card), c: method(:open_cards) }
      loop do
        puts "Пропустить ход - a\n
              Добавить карту - b\n
              Открыть карты - c"
        choice = gets.chomp.to_sym
        user_move.key?(choice) ? user_move[choice].call(@user) : incorrect_input
      end
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
    if @dealer.points >= 17 || @dealer.cards.size > 2 
      scip(@dealer)
    else
      add_card(@dealer)
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

  def open_cards(f)
    @user.show_cards 
    @dealer.show_cards
    scoring_2
  end

  def scoring_2
    @user.get_points
    @user.show_points
    @dealer.get_points
    @dealer.show_points
    define_winner
  end
  
  def define_winner
    @winner = nil
    if @user.points <= 21 && @dealer.points <= 21
      unless @user.points == @dealer.points
        @winner = @user.points > @dealer.points ? @user : @dealer
      end
    else 
      @winner = @user.points <= 21 ? @user : @dealer
    end
    cash_prize
  end
  
  def cash_prize
    if @winner
      @winner.bank += @bank
    else
      @user.bank += @bank/2
      @dealer.bank += @bank/2
    end
    show_winner
  end   

  def show_winner
    if @winner
      puts "Победил #{@winner.name}, выйгрыш составил #{@bank}$"
    else 
      puts "Ничья, ставки возвращаются в банк играков"
    end
    new_game
  end
  
  def new_game
    @bank = 0
    @user.cards = []
    @dealer.cards = []
    if @user.bank > 0
      puts "#{@user.name}, хотите сыграть ещё?\n
            Да - введите 1\n
            Нет - любая клавиша"
      choise = gets.to_i
      if choise == 1
        start_game
      else
        exit
      end
    else
      puts "#{@user.name}, Вы банкрот. Попробуйте устроится на работу!"
      sleep 10 
      exit
    end
  end            

  def incorrect_input
    puts 'Введено неверное значение'
  end

end
 


 
 
  
  