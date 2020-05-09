require './lib/turn'

class Basic < Turn
  def winner
    return_player_with_higher_card_at(0)
  end

  def pile_cards
    @spoils_of_war += [deck1, deck2].map(&:remove_card).shuffle
  end

  def message
    "#{winner.name} won 2 cards"
  end
end
