class Grid
  GRID_LEFT = 385
  GRID_RIGHT = 670
  GRID_TOP = 200
  GRID_BOTTOM = 790
  PX_PER_BLOCK = 28
  GRID_LENGTH = (GRID_RIGHT-GRID_LEFT)/PX_PER_BLOCK.floor

  attr_accessor :filled, :lines

  def initialize(window)
    @image = Gosu::Image.new(window, 'block.png', false)
    @filled = []
    @gameover = Gosu::Sample.new(window, "shrink.wav")
    @song = Gosu::Song.new(window, "tetris.wav")
    @song.play(true)
    @window = window
    @lines = 0
  end

  def self.nearest_x(x)
    nearest_x = ((x - GRID_LEFT)/PX_PER_BLOCK).round
    nearest_x = 0 if nearest_x == -1
    nearest_x
  end

  def self.nearest_y(y)
    nearest_y = (GRID_BOTTOM-y)/PX_PER_BLOCK
    nearest_y 0 if nearest_y == -1
    nearest_y
  end

  def self.y_to_px(y)
    GRID_BOTTOM-y*PX_PER_BLOCK
  end

  def self.x_to_px(x)
    GRID_LEFT+x*PX_PER_BLOCK
  end

  def fit_to_grid(piece)
    @to_fill = []

    firstxy = [Grid.nearest_x(piece.x), 0]
    firstxy = [firstxy[0], firstxy[1]+1] while @filled.include? firstxy
    @to_fill << firstxy

    shift_up = 0
    piece.current_shape.each do |shape_x,shape_y|
      shapexy = [firstxy[0] + shape_x,firstxy[1] + shape_y + shift_up]
      while @filled.include? shapexy
        shapexy = [shapexy[0], shapexy[1]+1]
        shift_up += 1
        @to_fill = @to_fill.map { |fill_x,fill_y| [fill_x,fill_y + 1] }
      end
      @to_fill << shapexy
    end

    if @to_fill.any? { |x,y| Grid.y_to_px(y) <= GRID_TOP }
      @song.stop
      @gameover.play
      sleep 3
      @window.gameover
      return
    end

    @filled = @filled | @to_fill
  end



  def check_for_lines
    @filled.map{|filled_x,filled_y| filled_y}.uniq.each do |filled_y|
      if (0..GRID_LENGTH).all? { |grid_x| p @filled; p [grid_x,filled_y]; @filled.include? [grid_x,filled_y] }
        @filled.each { |xy| @filled.delete(xy) if xy[1] == filled_y }
        @filled = @filled.map { |fill_x, fill_y| [fill_x, fill_y - 1] }
        @lines+=1
      end
    end
    p @lines
  end

  def draw
    @filled.each { |x,y| @image.draw(Grid.x_to_px(x),Grid.y_to_px(y), 100) }
  end
end
