puts "Введите Ваше имя"
name = gets.chomp
name.capitalize!
puts "Введите Ваш рост в см."
height = gets
ideal_weight = (height.to_i - 110) * 1.15
puts "#{name}, Ваш идеальный вес #{ideal_weight.to_i} кг." if ideal_weight > 0
puts "#{name}, Ваш вес уже оптимальный" if ideal_weight < 0

