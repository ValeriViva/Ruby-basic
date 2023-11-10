class Station
    attr_reader :trains
    
    def initialize(name)
        @name = name
        @trains = []
    end

    def take_train(train)
        @trains << train
    end
    
    def get_train_by_type(type)
        @trains.select{|train| train.type == type}.size 
    end # правильно ли я понимаю данный пункт тз? "Может возвращать список поездов на станции по типу (см. ниже): КОЛ-ВО грузовых, пассажирских" 
        # то есть нужно указывать сколько (цифру) поезов того или иного типа сейчас на станции? или достаточно просто списка? 
        # собственно, чтобы указать кол-во поездов по типу, здесь исползую метод size, а в предыдущем варианте пыталась реализовать через хэш
        # поясните, пожалуйста!
        
    def send_train(train)
        @trains.delete(train)
    end 
       
end

class Route
    attr_reader :stations
    
    def initialize(first_station, last_station)
        @stations = [first_station, last_station]
    end

    def add_station(station)
        stations.insert(-2, station)
    end   
    
    def delete_station(station)
        stations.delete(station) if station != stations.first && station != stations.last
    end

    def show_stations
        puts @stations
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
