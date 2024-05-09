#require_relative 'station'
require_relative 'company_module'
require_relative 'instance_counter_module'

class Train
  include ManufacturingCompany
  include InstanceCounter

  attr_accessor :speed
  attr_reader  :route, :number, :type, :carriages

  @@instances = 0
  @@trains = []

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @@instances += 1
    @@trains << self
    register_instance
  end

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end  
  
  def add_carriage
    if speed == 0
      carriage = create_carriage
      @carriages << carriage 
    end
  end

  def delete_carriage
    if speed == 0
      @carriages.delete_at(-1)
    end    
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
    current_station.take_train(self)
  end

  def move_to_next_station
    if next_station
      current_station.send_train(self)
      next_station.take_train(self)
      @current_station_index += 1 
    end
  end

  def move_to_previous_station
    if previous_station
      current_station.send_train(self)
      previous_station.take_train(self)
      @current_station_index -= 1
    end  
  end

  def stop
    @speed = 0
  end

  protected #следующие методы не используются извне данного класса, но могут использоваться в наследуемых классах

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index +1 < @route.stations.size 
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end

  def speed_increase
    @speed += 1
  end
  
  def create_carriage
    if @type == :passenger
      PassengerCarriage.new
    elsif @type == :cargo
      CargoCarriage.new
    end
  end
end 