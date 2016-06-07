require 'test/unit'
# require 'minitest/autorun'
require_relative '../lib/hand'

#Constants to test the poker ranks 

SF = %w{6C 7C 8C 9C 10C}           #Straight Flush [6 - 10 numerical order & same suits 'C']
FK = %w{9D 9H 9S 9C 7D}           #Four of a kind [four 9's & one 7]
FH = %w{10D 10C 10H 7C 7D}           #Full house [ Three T's (10's) & two 7's]
FL = %w{6C 9C 4C 8C 7C}           #Flush [all cards of same suites 'C']
S1 = %w{AS 2S 3S 4S 5C}           #Straight [A - 5] 
S2 = %w{AC 10C JC QS KS}           #Straight [2 -6]
TK = %w{5C 5D 5S 7H 8D}           #Three of a kind [three 5's & 2 different cards]
TP = %w{5S 5D 9H 9C 6S}           #Two pair [two 5's & two 9's & 1 different card]
OP = %w{5S 5D 8H 9C 6S}           #One pair [two 5's & remianing different cards]
HC = %w{AS 2S 3S 4S 6C}           #High [ A => 14]
SH = %w{2H 3S 4S 6C 7D}           #High [7]

DUPLICATE_CARD = %w{2S 3S 3S 6C 7D}           #error duplicate card
INVALID_CARD_COUNT = %w{2S 3S 6C 7D}           #error invalid  card count
INVALID_SUIT_CARD =  %w{2S 3S 6C 7D 8M}      #Here 8M -> M is invalid suit
INVALID_FACE_CARD =  %w{256S 3S 6C 7D 8C}    #Here 256S -> 256 is invalid face value 

class HandTest < Test::Unit::TestCase
# class HandTest < Minitest::Test

    def test_for_duplicate_cards
      exception = assert_raises(InvalidHandError) {Hand.new(['AC','AC','AC','8H','7S'])}
      assert "Error: Duplicate Cards Entered" ==  exception.message
    end

    def test_should_raise_exception_for_less_cards
      exception = assert_raises(InvalidHandError) {Hand.new(['10S', 'AC'])}
      assert "Error: Invalid card count. Require exact 5 cards" == exception.message
    end


  #Tests for Hand functions

    def test_straight_flush_high_card
      p = Hand.new(SF)
      assert p.find_hand_rank == ["Straight Flush", "High Card : 10C"]
    end

    def test_four_of_a_kind
      p = Hand.new(FK)
      assert p.find_hand_rank == ['Four of a Kind', "High Card : 9D"]
    end

    def test_full_house
      p = Hand.new(FH)
      assert p.find_hand_rank == ['Full House' , "High Card : 10D"]
    end

    def test_flush
      p = Hand.new(FL)
      assert p.find_hand_rank == ['Flush' , "High Card : 9C"]
    end

    def test_straight_to_check_ace_acts_as_low
      p = Hand.new(S1)
       assert p.find_hand_rank == ['Straight', "High Card : 5C"]
    end

    def test_straight_to_check_ace_acts_as_high
      p = Hand.new(S2)
      assert p.find_hand_rank == ['Straight' , "High Card : AC"]
    end

    def test_three_of_a_kind
      p = Hand.new(TK)
      assert p.find_hand_rank == ['Three of a Kind' , "High Card : 8D"]
    end

    def test_two_pair
      p = Hand.new(TP)
      assert p.find_hand_rank == ['Two Pair' , "High Card : 9H"]
    end

    def test_one_pair
      p = Hand.new(OP)
      assert p.find_hand_rank == ['One Pair', "High Card : 9C"]
    end

    def test_high_card
      p = Hand.new(HC)
      assert p.find_hand_rank == ["High Card : AS"]    # HC = [AS 2S 3S 4S 6C]
    end

  # #Tests for Poker private functions

    def test_for_straight_flush
      p =  Hand.new(SF)
      assert p.send(:straight) ==  true
      assert p.send(:flush) ==  true
      assert p.send(:two_pair) ==  false
    end
   
    def test_for_straight
      p =  Hand.new(S1)
      assert p.send(:straight) ==  true
      assert p.send(:flush) ==  false
    end

    def test_two_pair
      p = Hand.new(TP)
      assert p.send(:two_pair) == [5,9]
      assert p.send(:flush) == false
    end

    def test_kind_function
      p =  Hand.new(FK)
      assert p.send(:kind, 4, [9,9,9,9,7]) == 9
      assert p.send(:kind, 3, [9,9,9,9,7]) == false
      assert p.send(:kind, 3, [9,9,9,7,8]) == 9
      assert p.send(:kind, 2, [9,9,9,7,8]) == false
      assert p.send(:kind, 2, [5,5,6,7,8]) == 5
      assert p.send(:kind, 1, [9,9,9,9,8]) == 8
    end

    def test_for_get_high_card
      p =  Hand.new(SF)
      assert p.send(:get_high_card) == '10C'
    end

end
