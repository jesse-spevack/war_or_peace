require './test/test_helper'
require './lib/mutually_assured_destruction'

class MutuallyAssuredDestructionTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:heart, '2', 2)

    @card5 = Card.new(:diamond, 'Jack', 11)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '8', 8)
    @card8 = Card.new(:diamond, '2', 2)

    @expected_cards = [@card1, @card2, @card3, @card5, @card6, @card7]

    @deck1 = Deck.new([@card1, @card2, @card3, @card4])
    @deck2 = Deck.new([@card5, @card6, @card7, @card8])

    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)

    @subject = MutuallyAssuredDestruction.new(@player1, @player2)
  end

  def test_winner
    assert_equal 'No Winner', @subject.winner
  end

  def test_pile_of_cards
    assert @subject.spoils_of_war.empty?

    result = @subject.pile_cards
    assert @expected_cards.all? { |card| result.include?(card) }

    assert @subject.spoils_of_war.empty?
  end

  def test_type
    assert_equal :mutually_assured_destruction, @subject.type
  end
end
