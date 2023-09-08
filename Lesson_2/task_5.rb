puts "Введите день:"
day = gets.chomp.to_i
puts "Введите номер месяца:"
mn = gets.chomp.to_i
puts "Введите год:"
yr = gets.chomp.to_i
days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_in_month[2] = 29 if ((yr % 4 == 0) & (yr % 100 != 0)) || ((yr % 4 == 0) & (yr % 400 == 0))
date_number = days_in_month[0..mn-1].sum + day
puts "Порядковый номер даты: #{date_number}"


