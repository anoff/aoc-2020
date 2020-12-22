#!/usr/bin/ruby

def readInput(path)
  File.read(path).split("\n\n")
    .map{ |d|
      d.split("\n")[1..-1] # remove first line "header"
        .map(&:to_i)
    }
end

def game(deck1, deck2, debug=false)
  i = 0
  deck1 = deck1.reverse # make sure we generate copies so we do not mutate the outer scope decks for part2
  deck2 = deck2.reverse
  while deck1.size > 0 && deck2.size > 0
    card1 = deck1.pop
    card2 = deck2.pop
    if card1 > card2
      if debug
        puts "Player 1 wins (#{card1} vs #{card2})"
      end
      deck1.prepend(card1)
      deck1.prepend(card2)
    elsif card2 > card1
      if debug
        puts "Player 2 wins (#{card2} vs #{card1})"
      end
      deck2.prepend(card2)
      deck2.prepend(card1)
    else
      throw "draw :S"
    end
    i += 1
    if i > 1000
      throw "whoop whoop, this takes too long"
    end
  end
  return [deck1.reverse, deck2.reverse]
end

def part1 (deck1, deck2)
  result1, result2 = game(deck1, deck2)
  deck = result1.size > 0 ? result1 : result2
  deck.reverse.each_with_index
    .reduce(0){|sum, v|
      card = v[0]
      ix = v[1]
      sum + (ix+1)*card
    }
end

def game_recursive(deck1, deck2, debug=false)
  i = 0
  deckpool = []
  deck1 = deck1.reverse # make sure we generate copies so we do not mutate the outer scope decks for part2
  deck2 = deck2.reverse
  while deck1.size > 0 && deck2.size > 0
    decksCode = [deck1.map(&:to_s).join(""), deck2.map(&:to_s).join("")]
    if deckpool.include?(decksCode)
      if debug
        puts "Player 1 wins by causa infinite loop"
      end
      return ["winner=1", deck1.reverse, deck2.reverse]
    else
      deckpool.append(decksCode)
    end
    card1 = deck1.pop
    card2 = deck2.pop
    # recursion condition
    if card1 <= deck1.size && card2 <= deck2.size
      subdeck1 = deck1.reverse[0..(card1-1)]
      subdeck2 = deck2.reverse[0..(card2-1)]
      result = game_recursive(subdeck1, subdeck2, debug=debug)
      if result[0] == "winner-1"
        if debug
          puts "Player 1 wins (#{card1} vs #{card2})"
        end
        deck1.prepend(card1)
        deck1.prepend(card2)
      else
        if debug
          puts "Player 2 wins (#{card2} vs #{card1})"
        end
        deck2.prepend(card2)
        deck2.prepend(card1)
      end
    else
      if card1 > card2
        if debug
          puts "Player 1 wins (#{card1} vs #{card2})"
        end
        deck1.prepend(card1)
        deck1.prepend(card2)
      elsif card2 > card1
        if debug
          puts "Player 2 wins (#{card2} vs #{card1})"
        end
        deck2.prepend(card2)
        deck2.prepend(card1)
      else
        throw "draw :S"
      end
    end
    # i += 1
    # if i > 100000
    #   throw "whoop whoop, this takes too long"
    # end
  end
  if deck1.size == 0
    return ["winner=2", deck1.reverse, deck2.reverse]
  else
    return ["winner=1", deck1.reverse, deck2.reverse]
  end
end

def part2 (deck1, deck2)
  result, result1, result2 = game_recursive(deck1, deck2)
  deck = result == "winner=1" ? result1 : result2
  deck.reverse.each_with_index
    .reduce(0){|sum, v|
      card = v[0]
      ix = v[1]
      sum + (ix+1)*card
    }
end

if __FILE__ == $PROGRAM_NAME
  deck1, deck2 = readInput("./input.txt")
  puts "Solution for part1: #{part1(deck1, deck2)}"
  puts "Solution for part2: #{part2(deck1, deck2)}" # 35302 too high, 7875 too low
end
