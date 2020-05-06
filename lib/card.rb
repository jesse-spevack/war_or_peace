class Card
  MINIMUM_FACE_CARD_VALUE = 11

  attr_reader :suit,
              :value,
              :rank

  def initialize(suit, value, rank)
    @suit = suit
    @value = value
    @rank = rank
  end

  def face_card?
    rank >= MINIMUM_FACE_CARD_VALUE
  end
end
