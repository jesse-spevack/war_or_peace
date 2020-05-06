require './test/test_helper'
require './lib/card'

class CardTest < Minitest::Test
  def setup
    @subject = Card.new(:diamond, 'Queen', 12)
  end

  def test_it_exists
    assert_instance_of Card, @subject
  end

  def test_it_has_readable_attributes
    assert_equal :diamond, @subject.suit
    assert_equal 'Queen', @subject.value
    assert_equal 12, @subject.rank
  end

  def test_face_card
    assert_equal true, @subject.face_card?
    assert_equal false, Card.new(:spade, '10', 10).face_card?
  end
end
