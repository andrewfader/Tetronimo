require './grid'
class Piece
  attr_accessor :x, :y, :current_shape
  def initialize(window)
    @image = Gosu::Image.new(window, 'block.png', false)
    @x = 512
    @y = Grid::GRID_TOP
    type = [:I,:J,:L,:O,:S,:T,:Z].shuffle.first
    @shape = Piece.set_shape(type)
    @rotation = 0
  end

  def draw
    @image.draw(@x,@y,100)
    current_shape.each do |xy|
      @image.draw(@x+28*xy[0],@y+28*xy[1], 100)
    end
  end

  def current_shape
    @shape[@rotation]
  end

  def self.set_shape(type)
    case type
    when :I
      {0 => [[1,0],[2,0],[3,0]],
       1 => [[0,-1],[0,-2],[0,-3]],
       2 => [[-1,0],[-2,0],[-3,0]],
       3 => [[0,1],[0,2],[0,3]] }
    when :J
      {0 => [[1,0],[2,0],[2,-1]],
       1 => [[0,-1],[0,-2],[-1,-2]],
       2 => [[-1,0],[-2,0],[-2,1]],
       3 => [[0,1],[0,2],[1,2]] }
    when :L
      {0 => [[1,0],[2,0],[2,-1]],
       1 => [[0,-1],[0,-2],[-1,-2]],
       2 => [[-1,0],[-2,0],[-2,1]],
       3 => [[0,1],[0,2],[1,2]] }
    when :O
      [0,1,2,3].each_with_index.inject({}) do |hash,index|
        hash.merge!({index[0] => [[0,1],[1,1],[1,0]]})
      end
    when :S
      {0 => [[1,0],[0,-1],[-1,-1]],
       1 => [[0,-1],[1,-1],[1,-2]],
       2 => [[1,0],[0,-1],[-1,-1]],
       3 => [[0,-1],[1,-1],[1,-2]] }
    when :T
      {0 => [[-1,0],[1,0],[0,-1]],
       1 => [[0,-1],[0,1],[-1,0]],
       2 => [[1,0],[-1,0],[0,1]],
       3 => [[0,1],[0,-1],[1,0]] }
    when :Z
      {0 => [[-1,0],[-1,-1],[-2,-1]],
       1 => [[0,1],[1,1],[1,2]],
       2 => [[-1,0],[-1,-1],[-2,-1]],
       3 => [[0,1],[1,1],[1,2]] }
    end
  end

  def rotate_right
    @rotation < 3 ? @rotation += 1 : @rotation = 0
  end

  def rotate_left
    @rotation > 0 ? @rotation -= 1 : @rotation = 3
  end

  def move
    @y += 4
  end

  def move_left
    @x -= 12 if @x > Grid::GRID_LEFT
  end

  def move_right
    @x += 12 if @x < Grid::GRID_RIGHT
  end

  def drop_faster
    @y += 28
  end

end
