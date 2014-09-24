# Play Paper Rock Scissors!

require 'pry'
# get input of paper, rock or scissor
# generate random paper, rock or scissor for computer
# display what was picked by you and computer
# create method to output winner based on two selections
# prompt user if they want to play again (loop do...break if)

def winner(user, computer)
  winner = ""
  if (user == 'p' && computer == 'r')||
     (user == 's' && computer == 'p') ||
     (user == 'r' && computer == 's')
    winner = "You"
  elsif (computer == 'p' && user == 'r')||
     (computer == 's' && user == 'p') ||
     (computer == 'r' && user == 's')
    winner = "Computer"
  else
    winner = "tie"
  end
  
  if winner == "tie"
    puts "It's a tie!"
  else
    puts "#{winner} won!"
  end
end

comp_choices = ['p', 'r', 's']
to_word = {'p' => "Paper", 'r' => "Rock", 's' => "Scissor"}

puts "Play Paper Rock Scissors!"
loop do
  user = ""
  loop do
    puts "Choose one: (P/R/S)"
    user = gets.chomp.downcase
    break if user == 'r' || user == 'p' || user == 's'
  end
  comp = comp_choices.sample

  puts "You picked #{to_word[user]} and computer picked #{to_word[comp]}."
  winner(user,comp)

  puts "Play again? (Y/N)"
  again = gets.chomp.downcase

  break if again == 'n'
end