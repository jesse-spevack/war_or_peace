class Deck
  extend Forwardable

  attr_reader :cards
  def_delegators :@cards, :size, :empty?
  def_delegator :@cards, :shift, :remove_card
  def_delegator :@cards, :<<, :add_card

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    cards[index]&.rank
  end

  def high_ranking_cards
    @high_ranking ||= cards.select(&:face_card?)
  end

  def percent_high_ranking
    @percent_high_ranking ||= ((high_ranking_cards.count / size.to_f) * 100).round(2)
  end

  def draw_three
    3.times { self.remove_card }
  end
end
