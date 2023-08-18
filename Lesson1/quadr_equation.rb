puts "Введите коэффициенты а, b и с для квадратного уравнения ах^2 + bx + c = 0"
a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i
D = b ** 2 - 4 * a * c
if D > 0
    puts "D = #{D}, X1 = #{(- b + Math.sqrt(D)) / (a*2)}, X2 = #{(- b - Math.sqrt(D)) / (a*2)}"
elsif D == 0
    puts "D = #{D}, X = #{-b / (a*2)}"
    elsif D < 0
        puts "D = #{D}, корней нет"
    end
    
