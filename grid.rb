class Grid
  GRID_LEFT = 350
  GRID_RIGHT = 650
  GRID_TOP = 200
  GRID_BOTTOM = 800
  GRID_LENGTH = 10
  PX_PER_BLOCK = 28

  def initialize(window)
    @image = Gosu::Image.new(window, 'block.png', false)
    @filled = []
  end

  def fit_to_grid(piece)
    nearest_x = ((piece.x - GRID_LEFT)/PX_PER_BLOCK).floor
    nearest_y = 0

    @to_fill = []
    firstxy = [nearest_x, nearest_y]
    firstxy = [firstxy[0], firstxy[1]+1] while @filled.include? firstxy
    @to_fill << firstxy
    piece.current_shape.each do |xy|
      newxy = [firstxy[0]+xy[0],firstxy[1]+xy[1]]
      while @filled.include? newxy
        newxy = [newxy[0], newxy[1]+1]
        @to_fill = @to_fill.map do |xy|
          [xy[0], xy[1]+1]
        end
      end
      @to_fill << newxy
    end
    @filled = @filled | @to_fill
  end

  def draw
    @filled.each do |xy|
      @image.draw(GRID_LEFT+xy[0]*PX_PER_BLOCK,GRID_BOTTOM-xy[1]*PX_PER_BLOCK, 100)
    end
  end
end
