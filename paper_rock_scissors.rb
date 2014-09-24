# Play Paper Rock Scissors!

require 'pry'
# get input of paper, rock or scissor
# generate random paper, rock or scissor for computer
# display what was picked by you and computer
# create method to output winner based on two selections
# prompt user if they want to play again (loop do...break if)

def winner(user, computer)
  if user == 'p'
    if computer == 'p'
      puts "It's a tie."
    elsif computer == 'r'
      puts "You won!"
    elsif computer == 's'
      puts "Computer won!"
    end
  elsif user == 'r'
    if computer == 'p'
      puts "Computer won!"
    elsif computer == 'r'
      puts "It's a tie."
    elsif computer == 's'
      puts "You won!"
    end
  elsif user == 's'
    if computer == 'p'
      puts "You won!"
    elsif computer == 'r'
      puts "Computer won!"
    elsif computer == 's'
      puts "It's a tie."
    end
  end
end

def to_word(input)
  if input == 'p'
    "Paper"
  elsif input == 'r'
    "Rock"
  elsif input == 's'
    "Scissor"
  end
end

def comp_choice()
  rand = Random.new
  choice = rand.rand(1..3)
  if choice == 1
    "p"
  elsif choice == 2
    "r"
  elsif choice == 3
    "s"
  end
end

puts "Play Paper Rock Scissors!"
loop do
  user = ""
  loop do
    puts "Choose one: (P/R/S)"
    user = gets.chomp.downcase
    break if user == 'r' || user == 'p' || user == 's'
  end
  comp = comp_choice

  puts "You picked #{to_word(user)} and computer picked #{to_word(comp)}."
  winner(user,comp)

  puts "Play again? (Y/N)"
  again = gets.chomp.downcase

  break if again == 'n'
end