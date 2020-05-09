require './test/test_helper'
require './lib/basic'

class BasicTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)

    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])

    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)

    @subject = Basic.new(@player1, @player2)
  end

  def test_winner
    assert_equal @player1, @subject.winner
  end

  def test_pile_of_cards
    assert @subject.spoils_of_war.empty?

    @subject.pile_cards

    assert [@card1, @card3].all? { |card| @subject.spoils_of_war.include?(card) }
  end

  def test_type
    assert_equal :basic, @subject.type
  end
end
