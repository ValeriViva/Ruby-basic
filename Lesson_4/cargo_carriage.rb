require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize(total_capacity)
    @type = :cargo
    @occupied_capacity = 0
    super(total_capacity)
  end

  def occupy_capacity(capacity)
    #if @occupied_capacity + capacity <= @total_capacity
      #@occupied_capacity += capacity
    #else
      #puts "Недостаточно свободного места"
    #end
    if capacity <= available_capacity
      @occupied_capacity += capacity
    else
      puts "Доступно всего #{available_capacity} кубометров"
    end        
  end  
end

  