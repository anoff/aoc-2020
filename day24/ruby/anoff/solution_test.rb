require "test/unit"
require_relative './solution'

class TestSolution < Test::Unit::TestCase
  def test_tile1
    s = Tile.new(Pos2D.new(0, 0))
    tp = s.step("esenee")
    assert_equal Pos2D.new(3, 0), tp
  end
  def test_tile2
    s = Tile.new(Pos2D.new(3, 3))
    tp = s.step("nwwswee")
    assert_equal s.pos, tp
  end
  def test_part1
    input = readInput("./input_test.txt")
    assert_equal 10, part1(input)
  end
end