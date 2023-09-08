alphabet = Hash[(:a..:z).to_a.zip((1..26).to_a)]

vowels = [:a, :e, :i, :o, :u, :y]
vowels_hash = {}
alphabet.select {|letter, num| vowels_hash[letter] = num if vowels.include? letter}
puts vowels_hash




