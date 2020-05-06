class Type
  attr_reader :deck1,
              :deck2

  def initialize(deck1, deck2)
    @deck1 = deck1
    @deck2 = deck2
  end

  def scenario
    @scenario ||= if different_first_cards?
      :basic
    elsif same_first_cards? && same_third_cards?
      :mutually_assured_destruction
    elsif same_first_cards?
      :war
    end
  end

  private

  def same_cards_at?(index)
    deck1.rank_of_card_at(index) == deck2.rank_of_card_at(index)
  end

  def same_first_cards?
    @same_first_cards ||= same_cards_at?(0)
  end

  def same_third_cards?
    @same_third_cards ||= same_cards_at?(2)
  end

  def different_first_cards?
    !same_first_cards?
  end
end
