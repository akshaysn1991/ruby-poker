require_relative  'lib/hand'

#Receiving input from the terminal
begin
puts "Enter cards with face 2-10 (J K Q A) with a suit (H D S C)  \n EX: '9D QH 7S 8C 7D' or 9D QH 7S 8C 7D"
input = gets.chomp().gsub("'", "").gsub('"', "")
cards = input.split(' ')
hand = Hand.new(cards)
hand.find_hand_rank
rescue InvalidCardError => e
	puts e.message 
rescue InvalidHandError => e
	puts e.message 
end

# --------------------------------------------------------------------------------


# #Constants to check the poker hand rank manually 
# SF = %w{6C 7C 8C 9C 10C}           #Straight Flush [6 - 10 numerical order & same suits 'C']
# FK = %w{9D 9H 9S 9C 7D}           #Four of a kind [four 9's & one 7]
# FH = %w{10D 10C 10H 7C 7D}           #Full house [ Three T's (10's) & two 7's]
# FL = %w{6C 9C 4C 8C 7C}           #Flush [all cards of same suites 'C']
# S1 = %w{AS 2S 3S 4S 5C}           #Straight [A - 5] 
# S2 = %w{AC 10C JC QS KS}           #Straight [10 - a]
# TK = %w{5C 5D 5S 7H 8D}           #Three of a kind [three 5's & 2 different cards]
# TP = %w{5S 5D 9H 9C 6S}           #Two pair [two 5's & two 9's & 1 different card]
# OP = %w{5S 5D 8H 9C 6S}           #One pair [two 5's & remianing different cards]
# HC = %w{AS 2S 3S 4S 6C}           #High [ A => 14]
# SH = %w{2H 3S 4S 6C 7D}           #High [7]


# #Uncomment the below line and enter any one of the constants above  
# hand = Poker.new(FL)
# hand.find_hand_rank


# ---------------------------------------------------------------------------------



 




