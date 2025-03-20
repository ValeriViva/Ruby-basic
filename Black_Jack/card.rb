class Card
  attr_reader :suit, :value, :point

  def initialize (suit, value, point)
    @value = value
    @suit = suit
    @point = point
  end

end  