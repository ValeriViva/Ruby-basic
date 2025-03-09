class Card
  attr_reader :view, :value, :point

  def initialize (suit, value, point)
    @value = value
    @suit = suit
    @point = point
  end

end  