require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(total_capacity)
    @type = :passenger
    @occupied_capacity = 0
    super(total_capacity)
  end

  def take_seats
    @occupied_capacity += 1
  end  
end
  