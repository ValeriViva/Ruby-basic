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
    menu = {a: method(:create), b: method(:action), c: method(:display), ext: method(:exit)}
    loop do
      puts "Создать поезд, маршрут или станцию - a\n
            Произвести действия с объектом - b\n
            Вывести информацию на экран - c\n
            Выйти из программы - ext"
      choice = gets.chomp.to_sym
      menu.key?(choice) ? menu[choice].call : incorrect_input
    end
  end

  protected #чтобы нельзя было получить доступ к следующим методам извне данного класса 

  def create
    create = {a: method(:create_train), b: method(:create_station), c: method(:create_route)} #d: method(:break)}
    loop do
      puts "Создать поезд - a\n
            Создать станцию - b\n
            Создать маршрут - c\n
            Выйти в основное меню программы - ext"
      choice = gets.chomp.to_sym
      break if choice == :ext
      create.key?(choice) ? create[choice].call : incorrect_input
    end
  end

  def create_train
    puts "Введите номер поезда"
    number = gets.chomp.to_s
    puts "Введите тип поезда: passenger или cargo"
    type = gets.chomp
    train = if type == "passenger"
      PassengerTrain.new(number, type)
    elsif type == "cargo"
      CargoTrain.new(number, type)
    end     
    @trains << train
    puts "Поезд #{number} создан"
  rescue StandardError => e
    puts "Ошибка создания поезда: #{e.message}"
    puts e.backtrace.inspect
    retry
  end

  def create_station
    puts "Введите название станции" 
    name = gets.chomp
    station = Station.new(name)
    @stations << station
    #puts station.name
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
      route = Route.new(@stations[index1], @stations[index2])
      @routes << route
      #puts route
      #puts "маршрут: #{route.stations.first.name} - #{route.stations.last.name}"
    else
      puts "Создайте станции"
    end    
  end

  def action
    action = {a: method(:add_station), b: method(:delete_station), c: method(:add_route), d: method(:add_carriage), 
         e: method(:delete_carriage), f: method(:move_to_next_station), g: method(:move_to_previous_station), h: method(:take_capacity)}
    loop do
      puts "Добавить станцию к маршруту - a\n
            Убрать станцию из маршрута - b\n
            Назначить маршрут поезду - c\n
            Прицепить вагон к поезду -d\n
            Отцепить вагон от поезда - e\n
            Переместить поезд по маршруту вперед - f\n
            Переместить поезд по маршруту назад -g\n
            Занять место в вагоне - h\n
            Выйти в основное меню программы - ext"
      input = gets.chomp.to_sym
      break if input == :ext
      action.key?(input) ? action[input].call : incorrect_input
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
    route.show_stations
    station = @stations[gets.chomp.to_i]
    route.delete_station(station)
    puts route.stations.size
  end

  def add_route
    if @routes.size >= 1
      puts "Введите номер маршрута"
      display_route
      route = @routes[gets.chomp.to_i]
      puts "Введите порядковый номер поезда"
      display_trains
      train = @trains[gets.chomp.to_i]
      train.add_route(route)
      #puts "Поезд №#{train.number} находится на станции #{train.route.stations.first.name}"
    else
      puts "Сначала создайте маршрут"
    end   
  end

  def add_carriage
    puts "Введите порядковый номер поезда"
    display_trains
    train = @trains[gets.chomp.to_i]
    puts "Введите кол-во мест в вагоне для пассажирского поезда или общую вместимость для грузового"
    total_capacity = gets.chomp.to_i
    train.stop
    train.add_carriage(total_capacity)
    #puts train.carriages.size
  end
  
  def delete_carriage
    puts "Введите порядковый номер поезда"
    display_trains
    train = @trains[gets.chomp.to_i]
    train.stop
    if train.carriages.size > 0
      train.delete_carriage
    end 
    #puts train.carriages.size 
  end
  
  def move_to_next_station
    puts "Введите порядковый номер поезда"
    display_trains
    train = @trains[gets.chomp.to_i]
    if train.route
      train.move_to_next_station
    else
      puts "Чтобы переместить поезд по маршруту, сначала назначьте маршрут данному поезду"
    end  
  end
  
  def move_to_previous_station
    puts "Введите порядковый номер поезда"
    display_trains
    train = @trains[gets.chomp.to_i]
    if train.route
      train.move_to_previous_station
    else
      puts "Чтобы переместить поезд по маршруту, сначала назначьте маршрут данному поезду"
    end  
  end

  def take_capacity
    puts "Выбрать поезд"
    display_trains
    train = @trains[gets.chomp.to_i]
    puts "Выбрать номер вагона"
    train.each_carriage do |carriage, index|
      puts "Вагон № #{index += 1}, #{carriage.type}, свободно: #{carriage.available_capacity}"
    end  
    carriage = train.carriages[gets.chomp.to_i - 1]
    if carriage.available_capacity > 0
      if carriage.type == :cargo 
        puts "Если вагон грузовой, укажите какой объём нужно занять"
        carriage.occupy_capacity(gets.chomp.to_i)
      else carriage.type == :passenger
        puts "Пассажирские места занимаются по одному"
        carriage.take_seats
      end
    else
      puts "В данном вагоне нет свободного места"
    end    
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
    display = {a: method(:display_stations), b: method(:display_trains_on_station),c: method(:display_carriges)}
    loop do 
      puts"Вывести список станций - a\n
           Вывести список поездов на определённой станции - b\n
           Вывести список вагонов у определённого поезда - c\n
           Выйти в основное меню программы - ext"
      input = gets.chomp.to_sym
      break if input == :ext
      display.key?(input) ? display[input].call : incorrect_input
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
      station = @stations[choice]
    if station.trains.size >= 1
      station.each_train do |train|
        puts "Train: number #{train.number}, #{train.type}, #{train.carriages.size}"
      end   
    else
      puts "На данной станции нет поездов"  
    end  
  end

  def display_carriges
    puts "Выберите поезд"
    display_trains
    train = @trains[gets.chomp.to_i]
    train.each_carriage do |carriage, index|
      puts "Вагон № #{index += 1}, #{carriage.type}, занято: #{carriage.occupied_capacity}, свободно: #{carriage.available_capacity}"
    end  
  end
  
  def incorrect_input
    puts "Введено неверное значение"
  end  
end


railway = Railway.new

railway.menu

railway.create

railway.action

railway.display

