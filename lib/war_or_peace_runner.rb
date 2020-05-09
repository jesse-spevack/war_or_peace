require './lib/card_generator'
require './lib/player'
require './lib/basic'
require './lib/war'
require './lib/mutually_assured_destruction'
require 'forwardable'
require 'pry'

class WarOrPeaceRunner
  extend Forwardable

  attr_reader :player1,
              :player2

  def_delegator :@player1, :deck, :deck1
  def_delegator :@player2, :deck, :deck2

  def initialize(player1, player2)
    @player1 = player2
    @player2 = player1
    @turn_count = 0
  end

  def start
    print_welcome
    player_command = ''
    while player_command != 'GO'
      player_command = gets.chomp
    end

    run_game_loop
  end

  private

  def run_game_loop
    until game_over?
      increment_turn_count

      turn = if different_first_cards?
        Basic.new(player1, player2)
      elsif same_first_cards? && same_third_cards?
        MutuallyAssuredDestruction.new(player1, player2)
      elsif same_first_cards?
        War.new(player1, player2)
      end

      turn.pile_cards
      turn.award_spoils

      puts "Turn #{@turn_count}: #{turn.message}"
    end

    print_result
  end

  def print_result
    if turn_limit_exceeded?
      puts "---- DRAW ----"
    else
      puts "*~*~*~* #{winner} has won the game! *~*~*~*"
    end
  end

  def increment_turn_count
    @turn_count += 1
  end

  def game_over?
    either_player_lost? || turn_limit_exceeded?
  end

  def either_player_lost?
    [player1, player2].any?(&:has_lost?)
  end

  def turn_limit_exceeded?
    @turn_count > 1_000_000
  end

  def winner
    player1.has_lost? ? player2.name : player1.name
  end

  def same_cards_at?(index)
    deck1.rank_of_card_at(index) == deck2.rank_of_card_at(index)
  end

  def same_first_cards?
    @same_first_cards ||= same_cards_at?(0)
  end

  def same_third_cards?
    @same_third_cards ||= same_cards_at?(2)
  end

  def different_first_cards?
    !same_first_cards?
  end

  def print_welcome
    puts "Welcome to War! (or Peace) This game will be played with 52 cards.\nThe players today are Megan and Aurora.\nType 'GO' to start the game!\n------------------------------------------------------------------"
  end
end

cards = CardGenerator.new('cards.txt').cards.shuffle
first_half = cards.shift(cards.count / 2)

deck1 = Deck.new(first_half)
deck2 = Deck.new(cards)

player1 = Player.new('Aurora', deck1)
player2 = Player.new('Megan', deck2)

WarOrPeaceRunner.new(player1, player2).start
