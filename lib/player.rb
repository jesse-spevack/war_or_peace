class Player
  extend Forwardable

  attr_reader :name, :deck
  def_delegator :@deck, :remove_card
  def_delegator :@deck, :empty?, :has_lost?

  def initialize(name, deck)
    @name = name
    @deck = deck
  end
end
