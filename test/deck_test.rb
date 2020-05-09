require './test/test_helper'
require './lib/deck'

class DeckTest < Minitest::Test
  def setup
    @cards = [
      Card.new(:diamond, 'Queen', 12),
      Card.new(:spade, '3', 3),
      Card.new(:heart, 'Ace', 14),
    ]

    @subject = Deck.new(@cards)
  end

  def test_it_exists
    assert_instance_of Deck, @subject
  end

  def test_it_has_readable_attributes
    assert_equal @cards, @subject.cards
  end

  def test_rank_of_card_at
    assert_equal 12, @subject.rank_of_card_at(0)
    assert_equal 14, @subject.rank_of_card_at(2)
  end

  def test_high_ranking_cards
    assert_equal [@cards.first, @cards.last], @subject.high_ranking_cards
  end

  def test_percent_high_ranking
    assert_equal (2/3.to_f * 100).round(2), @subject.percent_high_ranking
  end

  def test_remove_card_return
    expected = @cards.first
    assert_equal expected, @subject.remove_card
  end

  def test_remove_card_deck
    expected = [@cards[1], @cards[2]]
    @subject.remove_card
    assert_equal expected, @subject.cards
  end

  def test_remove_card_high_ranking
    expected = [@cards[2]]
    @subject.remove_card
    assert_equal expected, @subject.high_ranking
  end

  def test_remove_card_high_ranking
    @subject.remove_card
    assert_equal 50, @subject.percent_high_ranking
  end

  def test_add_card
    card = Card.new(:club, '5', 5)
    expected = [@cards[1], @cards[2], card]
    @subject.remove_card
    @subject.add_card(card)
    assert_equal [expected[1]], @subject.high_ranking_cards
    assert_equal 33.33, @subject.percent_high_ranking
  end

  def test_draw_three
    assert @cards.all? { |card| @subject.draw_three.include?(card) }
  end
end
