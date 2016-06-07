class InvalidCardError < ArgumentError            
end

class Card
    
    attr_reader :face, :suit
    SUITS     = ['S', 'D', 'H', 'C']

    FACES = [2,3,4,5,6,7,8,9,10,11,12,13,14]
    
    SPECIAL_CARDS_FACE_VALUES = {
        'J' => 11,
        'Q' => 12,
        'K' => 13,
        'A' => 14 }

    def face_and_suit
         card_face_value = SPECIAL_CARDS_FACE_VALUES.key(face) ? SPECIAL_CARDS_FACE_VALUES.key(face) : face
         card_face_value.to_s + suit
    end

    def initialize(card)
        face_value = card[0..-2]
        if SPECIAL_CARDS_FACE_VALUES[face_value.upcase]
            @face = SPECIAL_CARDS_FACE_VALUES[face_value.upcase]
        else
            @face = face_value.to_i
        end
        fail InvalidCardError, 'Invalid Card Value' unless FACES.include?(face)
        @suit = card[-1].upcase
        fail InvalidCardError, 'Invalid Card Suit' unless SUITS.include?(suit) 
    end
end