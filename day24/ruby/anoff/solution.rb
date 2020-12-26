#!/usr/bin/ruby
require_relative './tile'

def readInput(path)
  File.read(path).split("\n")
end

def part1(input)
  refTile = Tile.new(Pos2D.new(0, 0))
  tiles = Array.new
  for line in input
    targetPos = refTile.step(line)
    existingTile = tiles.find{ |t| t.pos == targetPos}
    if not existingTile.nil?
      existingTile.flip
    else
      t = Tile.new(targetPos)
      t.flip
      tiles.append(t)
    end
  end
  tiles.filter{|t| t.color == "black"}.size
end

if __FILE__ == $PROGRAM_NAME
  input = readInput("./input.txt")
  puts "Solution for part1: #{part1(input)}"
  # puts "Solution for part2: #{part2(input)}"
end
