require './lib/card'

class CardGenerator
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def cards
    File.readlines(file_name).map do |line|
      value, suit, rank = line.split(', ')
      Card.new(suit.to_sym, value, rank.to_i)
    end
  end
end
