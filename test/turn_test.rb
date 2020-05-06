require './test/test_helper'
require './lib/turn'

class TurnTest < Minitest::Test
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

    @subject = Turn.new(@player1, @player2)
  end

  def test_attributes
    assert_equal @player1, @subject.player1
    assert_equal @player2, @subject.player2
  end

  def test_spoils_of_war
    assert_equal [], @subject.spoils_of_war
  end

  def test_turn_type_basic
    assert_equal :basic, @subject.type
  end

  def test_turn_type_war
    deck1 = Deck.new([@card1, @card2, @card3])
    deck2 = Deck.new([@card1, @card3, @card2])
    subject = Turn.new(Player.new('foo', deck1), Player.new('bar', deck2))
    assert_equal :war, subject.type
  end

  def test_turn_type_mutually_assured_destruction
    deck1 = Deck.new([@card1, @card2, @card3])
    deck2 = Deck.new([@card1, @card4, @card3])
    subject = Turn.new(Player.new('foo', deck1), Player.new('bar', deck2))
    assert_equal :mutually_assured_destruction, subject.type
  end

  def test_winner
    assert_equal @player1, @subject.winner
  end
end
