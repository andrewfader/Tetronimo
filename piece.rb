require './grid'
class Piece
  HORIZONTAL_MOVEMENT_AMOUNT = 28
  VERTICAL_MOVEMENT_AMOUNT = 12

  attr_accessor :x, :y, :current_shape
  def initialize(window, grid)
    @image = Gosu::Image.new(window, 'block.png', false)
    @x = 512
    @y = Grid::GRID_TOP
    # type = [:I, :O].shuffle.first
    type = [:I,:J,:L,:O,:S,:T,:Z].shuffle.first
    @shape = Piece.set_shape(type)
    @rotation = 0
    @grid = grid
    @window = window
  end

  def draw
    @image.draw(@x,@y,100)
    current_shape.each do |x,y|
      @image.draw(@x+Grid::PX_PER_BLOCK*x,@y+Grid::PX_PER_BLOCK*y, 100)
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
      (0..3).each_with_index.inject({}) do |hash,index|
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

  def move(amount=VERTICAL_MOVEMENT_AMOUNT)
    curx = Grid.nearest_x(@x)
    cury = Grid.nearest_y(@y)
    if (0..amount).any? { |test| @grid.filled.include?([curx,cury+test]) ||
                          current_shape.any? { |shape| @grid.filled.include?([curx + shape[0],cury + test - shape[1]]) } }
      @grid.fit_to_grid(self)
      @window.piece = Piece.new(@window, @grid)
    else
      @y += amount
    end
  end

  def move_left(amount=HORIZONTAL_MOVEMENT_AMOUNT)
    if @x > Grid::GRID_LEFT
      if current_shape.all? { |shape| @x + shape[0]*Grid::PX_PER_BLOCK > Grid::GRID_LEFT }
        if (0..amount).all? { |test| !@grid.filled.include?([Grid.nearest_x(@x-test),Grid.nearest_y(@y)]) &&
                          current_shape.all? { |shape| !@grid.filled.include?([Grid.nearest_x(@x-test + shape[0]*Grid::PX_PER_BLOCK),Grid.nearest_y(@y + shape[1]*Grid::PX_PER_BLOCK)]) } }
          @x -= amount
        end
      end
    end
  end

  def move_right(amount=HORIZONTAL_MOVEMENT_AMOUNT)
    if @x < Grid::GRID_RIGHT
      if current_shape.all? { |shape| @x + shape[0]*Grid::PX_PER_BLOCK < Grid::GRID_RIGHT }
        if (0..amount).all? { |test| !@grid.filled.include?([Grid.nearest_x(@x+test),Grid.nearest_y(@y)]) &&
                          current_shape.all? { |shape| !@grid.filled.include?([Grid.nearest_x(@x+test + shape[0]*Grid::PX_PER_BLOCK),Grid.nearest_y(@y + shape[1]*Grid::PX_PER_BLOCK)]) } }
          @x += amount
        end
      end
    end
  end

  def drop_faster
    move(28)
  end

end
