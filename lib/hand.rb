require_relative 'card'

class InvalidHandError < ArgumentError               
end
class Hand
  attr_reader :cards, :face_values
  
  HAND_SIZE = 5

  def initialize(hand_cards)
    @cards = []
    hand_cards.each do |hand_card|
      card = Card.new(hand_card)
        @cards << card 
    end

    playing_cards =  cards.collect{|card| card.face_and_suit}

    if playing_cards.length == HAND_SIZE && playing_cards.uniq.length != HAND_SIZE
      fail InvalidHandError, 'Error: Duplicate Cards Entered'
    elsif  playing_cards.length != HAND_SIZE
      fail InvalidHandError, 'Error: Invalid card count. Require exact 5 cards'
    end

      faces = cards.collect{|card| card.face}
      @face_values = faces.sort == [2,3,4,5,14] ? [1,2,3,4,5] : faces.sort  
  end


  #Returning Hand Ranks and High Card 
  def find_hand_rank
    high_card = get_high_card

    if straight && flush         #Straight Flush
      p ["Straight Flush", "High Card : #{high_card}"]

    elsif kind(4, face_values)          #4 of a kind
      p ["Four of a Kind",  "High Card : #{high_card}"]

    elsif kind(3, face_values) && kind(2, face_values)       #Full House
      p ["Full House",  "High Card : #{high_card}"]

    elsif flush        #Flush
      p ["Flush",  "High Card : #{high_card}"]

    elsif straight      #Straight
      p ["Straight" , "High Card : #{high_card}"]

    elsif kind(3, face_values)      #3 of a kind
      p ["Three of a Kind",  "High Card : #{high_card}"]

    elsif two_pair      #2 pair
      p ["Two Pair",  "High Card : #{high_card}"]     

    elsif kind(2, face_values) #Pair
      p ["One Pair",  "High Card : #{high_card}"]

    else   #High Card
      p ["High Card : #{high_card}"]
    end
  end

  private

  def straight
    (face_values.max - face_values.min == 4) && face_values.uniq.length == 5
  end

  def flush
    suits = cards.collect{|card| card.suit}
    suits.uniq.length == 1
  end
  
  def kind(n, face_values)
    face_values.each do |face_value|
      if face_values.count(face_value) == n
        return face_value
      end
    end
    return false
  end

  def two_pair
    first_pair = kind(2, face_values)
    second_pair = kind(2, face_values.reverse) 
    if first_pair && second_pair && (first_pair != second_pair)
      return [first_pair, second_pair]
    else
      return false
    end
  end

  #To get High card
  def get_high_card
    max_card = face_values.max
    cards.each do |card|
      if  max_card == card.face
        return card.face_and_suit
      end
    end
  end

end