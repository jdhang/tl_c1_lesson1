# Re-assigning the variable to something else
a = 5

3.times { a = 3 }

puts a

# method not mutating caller
b = [1, 2, 3, 3]

def some_method(arg)
  arg.uniq
end

p some_method(b)
p b

# method mutating caller
c = [1, 2, 3, 3]

def other_method(arg)
  arg.uniq!
end

p other_method(c)
p c

# trying to reference variable from inner, in the outer scope
3.times { e = 5 }
puts e