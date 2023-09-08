hash = {} 
loop do
    puts "Введите наименование товара или слово (стоп), если список закончен"
    product = gets.chomp
    break if product == "стоп"
    puts "Введите цену"
    price = gets.chomp.to_f
    puts "Введите количество"
    quantity = gets.chomp.to_f
    hash[product] = {price: price, quantity:quantity}
end
puts hash
total_amount = 0

hash.each do |key, velue|
    amount = velue[:price] * velue[:quantity]
    total_amount += amount
    puts "#{key}: итоговая стоимость - #{amount} руб."
end
puts "Общая сумма покупок: #{total_amount} руб."


