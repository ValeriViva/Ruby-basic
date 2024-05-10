require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize
    @type = :cargo
  end
end
  
  