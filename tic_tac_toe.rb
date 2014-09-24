require 'pry'

def show_board(array)
  system 'clear'
  row = "     |     |     "
  boundary = "-----+-----+-----"
  one_to_three = "  #{array[0]}  |  #{array[1]}  |  #{array[2]}  "
  four_to_six = "  #{array[3]}  |  #{array[4]}  |  #{array[5]}  "
  seven_to_nine = "  #{array[6]}  |  #{array[7]}  |  #{array[8]}  "

  board = [" ", row, one_to_three, row, boundary, row, four_to_six, row,
           boundary, row, seven_to_nine, row, " "]

  board.each {|i| puts i}
end

def comp_choice(array)
  if array.empty?
    false
  else
    choice = array.sample
  end
  array.delete(choice)
  choice
end

def winner?(array)
  winner = ""
  # check each row
  if (array[0] == "X" && array[1] == "X" && array[2] == "X") ||
     (array[3] == "X" && array[4] == "X" && array[5] == "X") ||
     (array[6] == "X" && array[7] == "X" && array[8] == "X") ||
     (array[0] == "X" && array[3] == "X" && array[6] == "X") ||
     (array[1] == "X" && array[4] == "X" && array[7] == "X") ||
     (array[2] == "X" && array[5] == "X" && array[8] == "X") ||
     (array[0] == "X" && array[4] == "X" && array[8] == "X") ||
     (array[2] == "X" && array[4] == "X" && array[6] == "X")
    winner = "You"
  elsif (array[0] == "O" && array[1] == "O" && array[2] == "O") ||
        (array[3] == "O" && array[4] == "O" && array[5] == "O") ||
        (array[6] == "O" && array[7] == "O" && array[8] == "O") ||
        (array[0] == "O" && array[3] == "O" && array[6] == "O") ||
        (array[1] == "O" && array[4] == "O" && array[7] == "O") ||
        (array[2] == "O" && array[5] == "O" && array[8] == "O") ||
        (array[0] == "O" && array[4] == "O" && array[8] == "O") ||
        (array[2] == "O" && array[4] == "O" && array[6] == "O") 
    winner = "Computer"
  elsif !(array.include?(" "))
    winner = "tie"
  end

  if winner == "tie"
    show_board(array)
    puts "It's a tie!"
    false
  elsif winner == "You" || winner == "Computer"
    show_board(array)
    puts "#{winner} won!"
    false
  else
    true
  end
end

def not_valid?(num)
  valid = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  if valid.include?(num)
    false
  else
    true
  end
end

pieces = Array.new(9, " ")
computer_choices = [0, 1, 2, 3, 4, 5, 6, 7, 8]
computer_choice = 0

loop do
  begin
    show_board(pieces)
    puts "Choose a position (from 1 to 9) to place a piece:"
    player_choice = gets.chomp.to_i
    if pieces[player_choice - 1] == "O" || pieces[player_choice - 1] == "X" 
      puts "That position is taken! Try again!"
      exit = false
    elsif not_valid?(player_choice)
      puts "Invalid position! Try again!"
      exit = false
    else
      exit = true
    end
  end until exit == true

  pieces[player_choice - 1] = "X"
  exit_test = !(winner?(pieces))

  if exit_test == false
    loop do
      exit = false
      computer_choice = comp_choice(computer_choices)
      if computer_choice
        if pieces[computer_choice] == " "
          pieces[computer_choice] = "O"
          exit = true
        end
      else
        exit = true
      end

      break if exit == true
    end
    exit_test = !(winner?(pieces))
  end

  break if exit_test == true
end
