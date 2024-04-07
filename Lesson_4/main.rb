require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'



class Railway
  def initialize
    @trains = []
    @stations = []
    @routes = []
  end

  def menu 

    #не заыбть удалить
    @trains << Train.new("323", :cargo)
    @trains << Train.new("222", :cargo)
    @trains << Train.new("111", :passenger)
    loop do
      puts "Создать поезд, маршрут или станцию- введите 1
            Произвести действия с объектом - введите 2
            Вывести информацию на экран - введите 3
            Выйти из программы - введите 0"
            choice = gets.chomp.to_i
      case choice
      when 1
        create
      when 2
        action
      when 3
        display
      when 0
        exit
      else
        puts "Введено ошибочное число"
      end
    end
  end

  protected

  def create
    loop do
      puts "Создать поезд - введите 1
            Создать станцию - введите 2
            Создать маршрут - введите 3
            Выйти в основное меню программы - введите 0"
            choice = gets.chomp.to_i
      case choice
      when 1
        create_train
      when 2
        create_station
      when 3
        create_route
      when 0
        break
      else
        puts "Введено ошибочное число"
      end
    end
  end

  def create_train
    puts "Введите номер поезда"
    number = gets.chomp
    puts "Введите тип поезда: passenger или cargo"
    type = gets.chomp
    puts "Создаём поезд"
    train = if type == "passenger"
      PassengerTrain.new(number, type)
    elsif type == "cargo"
      CargoTrain.new(number, type)
    else
      puts "Введите корректный тип поезда"
    end     
    puts "Создали поезд"
    @trains << train
    puts train.number
    puts train.type
    
  end

  def create_station
    puts "Введите название станции" 
    name = gets.chomp
    puts "Создаём станцию"
    station = Station.new(name)
    puts "Создали станцию"
    @stations << station
    puts station.name
    # puts station.trains.size
  end
  
  def create_route
    if @stations.size >= 2
      puts "Выбери первую станцию маршрута"
      @stations.each_with_index do |station, index|
        puts "#{index}-станция #{station.name}"
      end
       index1 = gets.chomp.to_i
      puts "Выбери последнюю станцию маршрута"
      @stations.each_with_index do |station, index|
      puts "#{index}-станция #{station.name}"
      end
        index2 = gets.chomp.to_i  
      puts "Создаём маршрут"
      route = Route.new(@stations[index1], @stations[index2])
      puts "Создали маршрут"
      @routes << route
      puts route
      puts "маршрут: #{route.stations.first.name} - #{route.stations.last.name}"
    else
      puts "Создайте станции"
    end    
  end

  def action
    loop do
      puts "Добавить станцию к маршруту - 1
      Убрать станцию из маршрута - 2
      Назначить маршрут поезду - 3
      Прицепить вагон к поезду -4
      Отцепить вагон от поезда - 5
      Переместить поезд по маршруту вперед - 6
      переместить поезд по маршруту назад -7
      Выйти в основное меню программы - 0"
      input = gets.chomp.to_i
      case input
      when 1
        add_station
      when 2
        delete_station
      when 3
        add_route
      when 4
        add_carriage
      when 5
        delete_carriage
      when 6
        move_to_next_station
      when 7
        move_to_previous_station
      when 0
        break
      else
        puts "Такого выбора не существует"
      end
    end        
  end     

  def add_station
    puts "Введите номер маршрута"
    display_route
    route = @routes[gets.chomp.to_i]
    puts "Введите номер станции"
    display_stations
    station = @stations[gets.chomp.to_i]
    route.add_station(station)
    puts route.stations.size
  end

  def delete_station
    puts "Введите номер маршрута"
    display_route
    route = @routes[gets.chomp.to_i]
    puts "Введите номер станции"
    display_stations
    station = @stations[gets.chomp.to_i]
    route.delete_station(station)
    puts route.stations.size
  end

  def add_route
    puts "Введите номер маршрута"
    display_route
    route = @routes[gets.chomp.to_i]
    puts "Введите порядковый номер поезда"
    display_trains
    train = @trains[gets.chomp.to_i]
    train.add_route(route)
  end

  def add_carriage
    puts "Введите порядковый номер поезда"
    display_trains
    train = @trains[gets.chomp.to_i]
    train.stop
    train.add_carriage
    puts train.carriages.size
  end
  
  def delete_carriage
    puts "Введите порядковый номер поезда"
    display_trains
    train = @trains[gets.chomp.to_i]
    train.stop
    if train.carriages.size > 0
      train.delete_carriage
    end 
    puts train.carriages.size 
  end
  
  def move_to_next_station
    puts "Введите порядковый номер поезда"
    display_trains
    train = @trains[gets.chomp.to_i]
    if train.route
    train.move_to_next_station
    else
      puts "Маршрут данному поезду пока не присвоен"
    end  
  end
  
  def move_to_previous_station
    puts "Введите порядковый номер поезда"
    display_trains
    train = @trains[gets.chomp.to_i]
    train.move_to_previous_station
  end

  def display_trains
    @trains.each_with_index do |train, index|
      puts "#{index} - поезд №#{train.number}"
    end
  end  

  def display_route
    @routes.each_with_index do |route, index|
      puts "#{index} - маршрут:#{route.stations[0].name} - #{route.stations[-1].name}"
    end
  end  


  def display
    loop do
      puts"Вывести список станций - введите 1
           Вывести список поездов на определённой станции - введите 2
           Выйти в основное меню программы - введите 0"
           input = gets.chomp.to_i
      case input
      when 1
        display_stations
      when 2
        display_trains_on_station
      when 0
        break
      else
        puts "Такого выбора не существует"
      end
    end        
  end

  def display_stations
    if @stations.size >= 1
      @stations.each_with_index do |station, index|
        puts "#{index}-станция #{station.name}"
      end
    else 
      puts "Нет доступных станций"
    end
  end
  
  def display_trains_on_station
    puts "Выберете интересуемую стацию"
    @stations.each_with_index do |station, index|
      puts "#{index}-станция #{station.name}"
    end  
      choice = gets.chomp.to_i
      station_trains = @stations[choice].trains
    if station_trains.size >= 1
      puts station_trains
    else
      puts "На данной станции нет поездов"  
    end  
  end

  

end


railway = Railway.new

railway.menu

railway.create

railway.action

railway.display


