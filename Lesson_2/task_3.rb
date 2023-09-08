fib = [0,1]
loop do
    f = fib[-1] + fib[-2]
break if f >= 100
fib.push(f)
end

print fib
puts
