require "test/unit"
require_relative './solution'

class TestSolution < Test::Unit::TestCase
  def test_destinationCup
    cups = [4, 5, 7, 8, 15]
    # assert_equal 15, destinationCup(cups, 16)
    # assert_equal 15, destinationCup(cups, 18)
    assert_equal 15, destinationCup(cups, 3)
    assert_equal 7, destinationCup(cups, 8)
  end

  def test_game
    cups = "389125467".split("").map(&:to_i)
    assert_equal [8,3,7,4,1,9,2,6,5], game(cups, 10)
  end

  def test_part1
    cups = "389125467"
    assert_equal "92658374", part1(cups, 10)
    assert_equal "67384529", part1(cups, 100)
  end
end