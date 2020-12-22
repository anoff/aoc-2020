require "test/unit"
require_relative './solution'

class TestSolution < Test::Unit::TestCase
  def test_readInput
    d1, d2 = readInput("./input_test.txt")
    assert_equal [9, 2, 6, 3, 1], d1
    assert_equal [5, 8, 4, 7, 10], d2
  end

  def test_game
    d1, d2 = readInput("./input_test.txt")
    assert_equal [[], [3, 2, 10, 6, 8, 5, 9, 4, 7, 1]], game(d1, d2)
  end

  def test_part1
    d1, d2 = readInput("./input_test.txt")
    assert_equal 306, part1(d1, d2)
  end
end