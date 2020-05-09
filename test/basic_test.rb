require './test/test_helper'
require './lib/basic'

class BasicTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:diamond, '2', 2)

    @deck1 = Deck.new([@card1])
    @deck2 = Deck.new([@card2])

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

    assert [@card1, @card2].all? { |card| @subject.spoils_of_war.include?(card) }
  end

  def test_type
    assert_equal :basic, @subject.type
  end

  def test_award_spoils
    @subject.pile_cards
    @subject.award_spoils
    expected_cards = @player1.deck.cards
    assert [@card1, @card2].all? { |card| expected_cards.include?(card) }
  end
end
