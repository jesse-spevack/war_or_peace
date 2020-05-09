class War < Turn
  def winner
    return_player_with_higher_card_at(3)
  end

  def pile_cards
    @spoils_of_war += [deck1, deck2].flat_map(&:draw_three).shuffle
  end
end
