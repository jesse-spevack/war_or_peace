require './lib/turn'
jj
class Basic < Turn
  def winner
    @winner ||= return_player_with_higher_card_at(0)
  end

  def pile_cards
    @spoils_of_war += [deck1, deck2].map(&:remove_card)
  end
end
