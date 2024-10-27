class Bank

  attr_accessor :player_account, :dealer_account

  #BET = 10

  def initialize #(player_account, dealer_account)
    @player_account = 100
    @dealer_account = 100
    # @accounts = [player_account, dealer_account]
    # puts @accounts
  end

  def place_bets 
    @player_account -= 10
    @dealer_account -= 10
  end
  
  def user_win
    place_bets
    @player_account += 20
  end
  
  def dealer_win
    place_bets
    @dealer_account += 20
  end  
  
  def dead_heat
    place_bets
    @player_account += 10
    @dealer_account += 10
  end
end    

  # bank = Bank.new("100", "100")
  # puts bank
  # puts @player_account

  # #bank.place_bets
  # puts @player_account


