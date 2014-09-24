def say(msg)
  puts "=> #{msg}"
end

say "Welcome to my Calculator:"
say "First Number: "
num1 = gets.chomp

say "Second Number: "
num2 = gets.chomp

say "Operators: 1-Add, 2-Subtract, 3-Multiply, 4-Divide: "
operator = gets.chomp

case operator
when '1'
  result = num1.to_i + num2.to_i
when '2'
  result = num1.to_i - num2.to_i
when '3'
  result = num1.to_i * num2.to_i
when '4'
  result = num1.to_f / num2.to_f
else
  puts "You entered a bad operator!"
end

say "Your result is #{result}"