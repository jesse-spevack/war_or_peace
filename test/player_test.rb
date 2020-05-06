require './test/test_helper'
require './lib/player'

class PlayerTest < Minitest::Test
  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @deck = Deck.new([@card1, @card2, @card3])
    @name = 'Clarisa'
    @subject = Player.new(@name, @deck)
  end

  def test_it_exists
    assert_instance_of Player, @subject
  end

  def test_it_has_readable_attributes
    assert_equal @name, @subject.name
    assert_equal @deck, @subject.deck
  end

  def test_has_lost
    assert_equal false, @subject.has_lost?

    # Remove two cards
    2.times do
      @deck.remove_card
      assert_equal false, @subject.has_lost?
    end

    # Remove final card
    @deck.remove_card
    assert_equal true, @subject.has_lost?
  end
end
