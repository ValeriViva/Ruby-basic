create

 


puts "Введите номер поезда"
number = gets.chomp
puts "Введите тип поезда"
type = gets.chomp
puts "Введите длина поезда"
train_length = gets.chomp
create_train(number, type, train_length)
puts @trains
puts "--------------------------------------"


def create_station(name)
  puts "Создаём станцию"
  station = Station.new(name)
  puts "Создали станцию"
  @stations << station
  puts station
  # puts station.trains.size
end
puts "Введите название станции" 
name = gets.chomp
# puts @stations.size
create_station(name)
puts @stations.size

puts "Введите название станции" 
name = gets.chomp
create_station(name)
puts "Введите название станции" 
name = gets.chomp
puts @stations.size
create_station(name)
puts @stations.size

st2 = @stations[1]

st1 = @stations[0]
puts st1.trains.size

tr1 = @trains[0]
# st1.take_train(tr1)
# puts st1.trains.size
puts "--------------------------------------"


def create_route(first_station, last_station)
  puts "Создаём маршрут"
  route = Route.new(first_station, last_station)
  puts "Создали маршрут"
  @routes << route
  puts route
end

# puts "Введите название первой станции" 
# first_station = gets.chomp
# puts "что я ввела в первую станцию"
# puts first_station
# puts "что реально лежит в первой станции"
# puts st1
# puts st1.name
# puts "Введите название последней станции"
# last_station = gets.chomp



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

create_route(@stations[index1], @stations[index2])

puts "Выведи станции маршрута"

@routes[0].stations.each_with_index do |station, index|
  puts "#{index}-станция #{station.name}"
end
end

