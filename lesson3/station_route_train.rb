class Station
    attr_reader :trains 
    
    def initialize(station_name)
        @station_name = station_name
        trains = []
    end

    def take_train(train)
        trains << train
    end
    
    def send_train(train)
        trains.delete(train)

    end 
    
    def trains_by_type(type)
        trains.select { |train| train.type == type}
end

class Route
    def initialize(first_station, last_station)
        @first_station = first_station
        @last_station = last_station
        @station_list = [first_station, last_station]
    end

    def add_station(station_name)
        @station_number
        @station_list
        @station_list.each {|station| puts station}

    end   
    
    def delete_station(station_name)
        @station_list
    end

end     

