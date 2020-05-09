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
end
