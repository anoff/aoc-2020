#!/usr/bin/ruby

def readInput(path)
  input = File.read(path).split("").map(&:to_i)
  return input
end

def destinationCup(cups, currentCup)
  currentCup -= 1
  while not cups.include?(currentCup)
    currentCup -= 1
    if currentCup < 1
      currentCup = cups.max
    end
  end
  return currentCup
end

def game(cups, turns)
  for turn in 1..turns
    # p "Move #{turn}: #{cups.map(&:to_s).join(" ")}"
    currentCup = cups[0]
    selectedCups = cups[1..3]
    cups = cups.drop(4)
    cups.prepend(currentCup)
    destinationCup = destinationCup(cups, currentCup)
    destinationIx = cups.find_index(destinationCup)
    for i in 0..2
      cups.insert(destinationIx+i+1, selectedCups[i])
    end
    # move forward, rotate
    cups.push(cups.shift)
  end
  return cups
end
def part1(input, turns)
  cups = input.split("").map(&:to_i)
  result = game(cups, turns)
  while result[0] != 1
    result.push(result.shift)
  end
  result[1..-1].map(&:to_s).join("")
end


def part2(input)
  2
end

if __FILE__ == $PROGRAM_NAME
  puts "Solution for part1: #{part1('137826495', 100)}"
  puts "Solution for part2: #{part2('137826495')}"
end
