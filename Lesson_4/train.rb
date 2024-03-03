class Train
  attr_accessor :train_length
  attr_reader :speed, :route, :number, :type

  def initialize(number, type, train_length)
      
      @number = number
      @type = type
      @train_length = train_length
  end

  def speed_increase
      @speed += 1
  end    
  
  def stop
      @speed = 0
  end
  
  def add_carriage
      train_length += 1 if speed == 0
  end

  def delete_carriage
      train_length -= 1 if speed == 0
  end

  def add_route(route)
      @route = route
      @current_station_index = 0
      current_station.take_train(self)
  end

  def current_station
      @route.stations[@current_station_index]
  end

  def next_station
      @route.stations[@current_station_index + 1] if @current_station_index +1 < @route.stations.size 
  end

  def previous_station
      @route.stations[@current_station_index - 1] if @current_station_index > 0
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
end 