class Station
    attr_reader :trains
    
    def initialize(name)
        @name = name
        @trains = []
        @trains_by_type = {}
    end

    def take_train(train)
        @trains << train
         if trains_by_type[train.type] 
            trains_by_type[train.type] += 1
         else 
            trains_by_type[train.type] = 1
         end
    end
    
    def get_train_by_type(type)
        @trains_by_type[type]
    end

    def send_train(train)
        trains.delete(train)
    end 
       
end

class Route
    attr_reader :station_list
    
    def initialize(first_station, last_station)
        @station_list = [first_station, last_station]
    end

    def add_station(station)
        station_list.incert(-2, station)
    end   
    
    def delete_station(station)
        station_list.delete(station) if station != station_list.first && station != station_list.last
    end

    def show_station_list
        puts @station_list
    end    

end     

class Train
    attr_accessor :train_length
    attr_reader :speed, :route

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
    
    def add_wagons
        train_length += 1 if speed == 0
    end

    def delete_wagons
        train_length -= 1 if speed == 0
    end

    def add_route(route)
        @route = route
        @current_station_index = 0
        current_station.take_train(self)
    end

    def current_station
        @route.station_list[@current_station_index]
    end

    def next_station
        @route.station_list[@current_station_index + 1] if @current_station_index +1 < @route.station_list.size 

    end

    def prev_station
        @route.station_list[@current_station_index - 1] if @current_station_index > 0
    end

    def move_to_next_station
      if next_station
        current_station.send_train(self)
        next_station.take_train(self)
        @current_station_index += 1
      end

    end

    def move_to_prev_station
        if prev_station
          current_station.send_train(self)
          prev_station.take_train(self)
          @current_station_index -= 1
        end  

    end
end 


