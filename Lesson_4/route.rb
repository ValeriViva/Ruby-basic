require_relative 'instance_counter_module'

class Route
  include InstanceCounter

  attr_reader :stations
  
  
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
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
end     