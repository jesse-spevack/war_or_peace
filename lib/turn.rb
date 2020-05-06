# frozen_string_literal: true

require './lib/type'

class Turn
  extend Forwardable

  NO_WINNER = 'No Winner'

  attr_reader :player1,
              :player2,
              :spoils_of_war,
              :type

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def_delegator :@player1, :deck, :deck1
  def_delegator :@player2, :deck, :deck2

  def type
    @type ||= Type.new(deck1, deck2).scenario
  end

  def winner
    case type
    when :basic
      player_with_higher_first_card
    when :war
      player_with_higher_third_card
    when :mutually_assured_destruction
      NO_WINNER
    end
  end

  def pile_cards
    @spoils_of_war = case type
      when :basic
        [deck1, deck2].map(&:remove_card)
      when :war
        [deck1, deck2].flat_map(&:draw_three)
      when :mutually_assured_destruction
        [deck1, deck2].flat_map(&:draw_three)
        []
      end
  end

  private

  def player_with_higher_first_card
    return_player_with_higher_card_at(0)
  end

  def player_with_higher_third_card
    return_player_with_higher_card_at(3)
  end

  def return_player_with_higher_card_at(index)
    deck1.rank_of_card_at(index) > deck2.rank_of_card_at(index)? player1 : player2
  end
end
