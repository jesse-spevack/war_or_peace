class MutuallyAssuredDestruction < Turn
  NO_WINNER = 'No Winner'

  def winner
    @winner ||= NO_WINNER
  end

  def pile_cards
    [deck1, deck2].flat_map(&:draw_three)
  end

  def type
    :mutually_assured_destruction
  end

  def award_spoils
    nil
  end

  def message
    "*mutually assured destruction* 6 cards removed from play"
  end
end
