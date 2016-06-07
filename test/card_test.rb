require 'test/unit'
# require 'minitest/autorun'
require_relative '../lib/card'

class CardTest < Test::Unit::TestCase
# class CardTest < Minitest::Test

    def test_special_card_constants
        assert Card::SPECIAL_CARDS_VALUE == {"J"=>11, "Q"=>12, "K"=>13, "A"=>14}
    end

    def test_special_card_constants
        assert Card::SUITS == ['S', 'D', 'H', 'C']
    end

    def test_card_initilization
        card = Card.new('10S')
        assert card.face == 10 
        assert card.suit == 'S'
    end

    def test_special_card_initilization
        card = Card.new('KS')
        assert card.face == 13
        assert card.suit == 'S'
    end

    def test_for_invalid_suit
        exception = assert_raises(InvalidCardError) {Card.new('AX')}
        assert "Invalid Card Suit" ==  exception.message
    end

    def test_for_invalid_card_value
        exception = assert_raises(InvalidCardError) {Card.new('234S')}
        assert "Invalid Card Value" ==  exception.message
    end
    
end