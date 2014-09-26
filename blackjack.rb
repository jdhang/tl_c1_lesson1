# Ask for player's name
# Initialize a deck of cards
# Deal 2 cards to the player and two to the dealer (1 at a time)
  # Remove cards from deck
# Ask player if they want to "hit" or "stay"
  # "hit" would deal another card to the player
  # "stay" would prompt the dealer's turn
# Dealer card total needs to be at least 17
  # dealer "hit" until then OR until total > 21 (bust) OR total = 21 (you lose)
# prompt user if they want to play again
# --- REQUIRES ---
require 'pry'
# --- END OF REQUIRES -- 

# --- METHODS ---
def create_deck(num)
  suits = ['Heart', 'Diamond', 'Spade', 'Club']
  values = ['Ace', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King']
  deck = Array.new
  
  num.times do
    suits.each do |s|
      values.each do |v|
        card = {suit: s, value: v}
        deck.push(card)
      end
    end
  end
  deck
end

def deal(deck)
  deck.shuffle!.pop
end

def create_player()
  return player_info = {name: "", cards: []}
end

def create_dealer()
  return dealer = {name: "dealer", cards: []}
end

def start_game(player, dealer, deck)
  player[:cards].push(deal(deck))
  dealer[:cards].push(deal(deck))
  player[:cards].push(deal(deck))
  dealer[:cards].push(deal(deck))
end

def hit_or_stay(player, deck)
  puts "Hit or Stay?"
  option = gets.chomp.downcase
  if option == "hit" || option == "h"
    player[:cards].push(deal(deck))
    display_hand(player)
    false
  elsif option == "stay" || option == "s"
    puts "You choose to Stay!"
    true
  else
    puts "Huh? Invalid input, try again!"
    false
  end
end

def dealers_turn(player, deck)
  cards = player[:cards]
  if cards.length == 2
    puts
    puts "Dealer's turn"
    puts "-------------"
    display_hand(player)
  end
  if get_total(cards) < 17
    card = deal(deck)
    cards.push(card)
    if card[:value] == "Ace"
      text = "=> Dealer hits and draws an "
    else
      text = "=> Dealer hits and draws a "
    end
    puts "-------------------------------------------"
    puts text + "#{card[:value]} of #{card[:suit]}s"
    puts "=> Dealer's Card total: #{get_total(cards)}"
    puts "-------------------------------------------"
    puts
  end  
end

def display_hand(player)
  puts
  puts player[:name] == "dealer" ? "Dealer's Hand:" : "Your Hand:"
  player[:cards].each do |card|
    puts "=> #{card[:value]} of #{card[:suit]}s"
  end
  total = get_total(player[:cards])
  puts "Card total: #{total}"
  puts "---------------"
  puts
end

def get_total(cards)
  total = 0
  ace_count = 0
  cards.each do |card|
    if card[:value] == "Ace"
      total += 11
      ace_count += 1
    elsif (card[:value] =~ /J|Q|K/) == 0
      total += 10
    else
      total += card[:value]
    end
  end
  total -= (ace_count * 10) if total > 22
  total
end

def blackjack?(player)
  total = get_total(player[:cards])
  check = {game_over: true, status: ""}
  if total == 21
    player[:name] == "dealer" ? check[:status] = "d_blackjack" : check[:status] = "blackjack"
    check[:game_over] = true
  elsif total > 21
    player[:name] == "dealer" ? check[:status] = "d_bust" : check[:status] = "bust"
    check[:game_over] = true
  elsif total >= 17
    player[:name] == "dealer" ? check[:status] = "d_max" : check[:status] = ""
    check[:game_over] = false
  else
    check[:game_over] = false
  end
  check
end

def compare(player, dealer)
  winner = ""
  player_total = get_total(player[:cards])
  dealer_total = get_total(dealer[:cards])
  if player_total > dealer_total
    winner = "player"
  elsif player_total < dealer_total
    winner = "dealer"
  else
    winner = "tie"
  end
  winner
end

def announce(winner, game_status, player)
  result = game_status[:status]
  name = player[:name]
  text = ""
  if winner
    case winner
    when "player"
      text = "Congrats #{name}, You won!"
    when "dealer"
      text = "Dealer won!"
    when "tie"
      text = "It's a tie!"
    end
  else
    case result
    when "blackjack"
      text = "Blackjack! Congrats #{name}, You won!"
    when "bust"
      text = "Busted! Sorry #{name}, You lost!"
    when "d_blackjack"
      text = "Dealer Blackjack! You lost!"
    when "d_bust"
      text = "Dealer Bust! You won!"
    end
  end
  puts text    
end
# --- END OF METHODS ---

# --- START OF PROGRAM ---
system "clear"
puts
puts "Welcome to Blackjack!"

deck_num = 2
puts
puts "Number of Decks Played: #{deck_num}"
puts
player = create_player
puts "Let's start with your name:"
player[:name] = gets.chomp
puts
puts "--------------------------------------------"
puts "Hi #{player[:name]}! Let's start playing!"
puts "--------------------------------------------"

loop do
  deck = create_deck(deck_num)
  dealer = create_dealer
  player[:cards] = []
  start_game(player, dealer, deck)
  display_hand(player)
  game_status = blackjack?(player)
  unless game_status[:game_over]
    begin
      exiting = hit_or_stay(player, deck)
      game_status = blackjack?(player)
    end until exiting == true || game_status[:game_over]
    unless game_status[:game_over]
      begin
        dealers_turn(dealer, deck)
        game_status = blackjack?(dealer)
      end until game_status[:game_over] || game_status[:status] == "d_max"
    end
    winner = compare(player, dealer) unless game_status[:game_over]
  end
  announce(winner, game_status, player)
  puts
  puts "Play again? (Y/N)"
  break if gets.chomp.downcase != "y"
  puts
  puts "----------------------------------------"
  puts "Okay #{player[:name]}, let's play again!"
end
# --- END OF PROGRAM ---