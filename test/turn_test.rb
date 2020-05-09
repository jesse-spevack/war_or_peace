require './test/test_helper'
require './lib/turn'

class TurnTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)

    @deck1 = Deck.new([@card1])
    @deck2 = Deck.new([@card2])

    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)

    @subject = Turn.new(@player1, @player2)
  end

  def test_attributes
    assert_equal @player1, @subject.player1
    assert_equal @player2, @subject.player2
    assert @subject.spoils_of_war.empty?
  end
end
