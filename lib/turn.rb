# frozen_string_literal: tru  e

class Turn
  extend Forwardable

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

  def award_spoils
    winner.deck += @spoils_of_war
  end

  def type
    @type ||= self.class.name.downcase.to_sym
  end

  private

  def return_player_with_higher_card_at(index)
    deck1.rank_of_card_at(index) > deck2.rank_of_card_at(index)? player1 : player2
  end
end
