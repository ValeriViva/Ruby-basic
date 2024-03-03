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

  def create
    loop do
      puts "Создать поезд - введите 1
            Создать станцию - введите 2
            Создать маршрут - введите 3
            Выйти из программы - введите 0"
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
    puts "Введите тип поезда"
    type = gets.chomp
    puts "Введите длина поезда"
    train_length = gets.chomp
    puts "Создаём поезд"
    train = Train.new(number, type, train_length)
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
      puts "Добавить станцию к маршруту -1
      Убрать станцию из маршрута - 2
      Назначить маршрут поезду - 3
      Прицепить вагон к поезду -4
      Отцепить вагон от поезда - 5
      Переместить поезд по маршруту вперед - 6
      переместить поезд по маршруту назад -7
      Выйти из программы - 0"
      input = gets.chomp.to_i
      case input
      when 1
        add_station(station)
      when 2
        delete_station(station)
      when 3
        add_route(route)
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




  def display
    loop do
      puts"Вывести список станций - введите 1
           Вывести список поездов на определённой станции - введите 2
           Выйти из программы - введите 0"
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

    if @trains.size >= 1
      puts @stations[choice].trains
    end  

  end


end


railway = Railway.new

railway.create

railway.action

railway.display


