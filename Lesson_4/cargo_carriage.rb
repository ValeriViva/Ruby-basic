require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize(total_capacity)
    @type = :cargo
    @occupied_capacity = 0
    super(total_capacity)
  end

  def occupy_capacity(capacity)
    @occupied_capacity += capacity #unless @occupied_capacity < @total_capacity
  end  
end

  