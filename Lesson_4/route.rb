require_relative 'instance_counter_module'

class Route
  include InstanceCounter

  attr_accessor :stations, :first_station, :last_station
  
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    if station != stations.first && station != stations.last
      stations.insert(-2, station)
    else
      puts "Данная станция является начальной/конечной станцией маршрута. Выберете другую станцию"
    end         
  end   
  
  def delete_station(station)
    if station != stations.first && station != stations.last
      stations.delete(station)
    else
      puts "Данная станция является начальной/конечной станцией маршрута. Выберете другую станцию"
    end 
  end

  def show_stations
    @stations.each_with_index do |station, index|
        puts "#{index}-станция #{station.name}"
    end
  end

  def valid?
    validate!
  rescue StandardError
    false
  end
  
  protected

  def validate!
    raise "First station can't be nil" if @stations.first.nil?
    raise "Last station can't be nil" if @stations.last.nil?
    raise "Name of first station should be at least 2 symbols" if @stations.first.length < 2
    raise "Name of last station should be at least 2 symbols" if @stations[-1].length < 2
    true
  end
end     