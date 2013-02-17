require './grid'
require 'matrix'
class Piece
  HORIZONTAL_MOVEMENT_AMOUNT = 28
  VERTICAL_MOVEMENT_AMOUNT = 12

  attr_accessor :x, :y, :shape
  def initialize(window, grid, type=nil)
    @image = Gosu::Image.new(window, 'block.png', false)
    @x = 512
    @y = Grid::GRID_TOP
    type ||= [:I,:J,:L,:O,:S,:T,:Z].shuffle.first
    @shape =
      {I: [[1,0],[2,0],[3,0]],
       J: [[1,0],[2,0],[2,-1]],
       L: [[1,0],[2,0],[2,-1]],
       O: [[0,1],[1,1],[1,0]],
       S: [[1,0],[0,-1],[-1,-1]],
       T: [[-1,0],[1,0],[0,-1]],
       Z: [[-1,0],[-1,-1],[-2,-1]]}[type]
    @grid = grid
    @window = window
  end

  def draw
    @image.draw(@x,@y,100)
    @shape.each do |x,y|
      @image.draw(@x+Grid::PX_PER_BLOCK*x,@y+Grid::PX_PER_BLOCK*y, 100)
    end
  end

  def rotate
    @shape = @shape.map{|arr|(Matrix[arr] * Matrix[[0,-1],[1,0]]).to_a.flatten}
  end

  def move(amount=VERTICAL_MOVEMENT_AMOUNT)
    curx = Grid.nearest_x(@x)
    cury = Grid.nearest_y(@y)
    if (0..amount).any? { |test| @grid.filled.include?([curx,cury+test]) ||
                          @shape.any? { |shape| @grid.filled.include?([curx + shape[0],cury + test - shape[1]]) } }
      @grid.fit_to_grid(self)
      @window.piece = Piece.new(@window, @grid)
    else
      @y += amount
    end
  end

  def move_left(amount=HORIZONTAL_MOVEMENT_AMOUNT)
    if @x > Grid::GRID_LEFT
      if @shape.all? { |shape| @x + shape[0]*Grid::PX_PER_BLOCK > Grid::GRID_LEFT }
        if (0..amount).all? { |test| !@grid.filled.include?([Grid.nearest_x(@x-test),Grid.nearest_y(@y)]) &&
          @shape.all? { |shape| !@grid.filled.include?([Grid.nearest_x(@x-test + shape[0]*Grid::PX_PER_BLOCK),Grid.nearest_y(@y + shape[1]*Grid::PX_PER_BLOCK)]) } }
          @x -= amount
        end
      end
    end
  end

  def move_right(amount=HORIZONTAL_MOVEMENT_AMOUNT)
    if @x < Grid::GRID_RIGHT
      if @shape.all? { |shape| @x + shape[0]*Grid::PX_PER_BLOCK < Grid::GRID_RIGHT }
        if (0..amount).all? { |test| !@grid.filled.include?([Grid.nearest_x(@x+test),Grid.nearest_y(@y)]) &&
          @shape.all? { |shape| !@grid.filled.include?([Grid.nearest_x(@x+test + shape[0]*Grid::PX_PER_BLOCK),Grid.nearest_y(@y + shape[1]*Grid::PX_PER_BLOCK)]) } }
          @x += amount
        end
      end
    end
  end

  def drop_faster
    move(28)
  end

end
