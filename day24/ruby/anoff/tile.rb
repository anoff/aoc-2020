class Tile
  attr_reader :pos, :color
  def initialize(pos)
    @pos = pos
    @color = "white"
    return self
  end

  # return Pos2D of targe tile
  #   odd-row implementation
  #   https://www.redblobgames.com/grids/hexagons/#coordinates
  def step(sequence)
    target = Pos2D.new(@pos.x, @pos.y)
    while sequence.size > 0
      if sequence[0] == "e"
        target.move(1, 0)
        sequence.slice!(0)
      elsif sequence[0] == "w"
        target.move(-1, 0)
        sequence.slice!(0)
      elsif sequence[0..1] == "se"
        target.move(target.y%2, 1) # use modulo to only move on uneven rows
        sequence.slice!(0..1)
      elsif sequence[0..1] == "sw"
        target.move(-((target.y+1)%2), 1)
        sequence.slice!(0..1)
      elsif sequence[0..1] == "nw"
        target.move(-((target.y+1)%2), -1)
        sequence.slice!(0..1)
      elsif sequence[0..1] == "ne"
        target.move(target.y%2, -1)
        sequence.slice!(0..1)
      else
        throw "Unexpected step sequence #{sequence}"
      end
    end
    return target
  end

  def flip
    @color = (@color == "white") ? "black" : "white"
    return self
  end
end


class Pos2D
  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(o)
    @x == o.x && @y == o.y
  end

  def move(dx, dy)
    @x += dx
    @y += dy
  end
end