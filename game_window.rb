require 'rubygems'
require 'gosu'
require './piece'
class GameWindow < Gosu::Window
  def initialize
    super 1024, 960, false
    self.caption = "Tetronimo"

    @background_image = Gosu::Image.new(self, "bg.png", true)
    @grid = Grid.new(self)
    @piece = Piece.new(self, @grid)
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @piece.move_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @piece.move_right
    end
     if button_down? Gosu::KbDown or button_down? Gosu::GpDown then
      @piece.drop_faster
     end
     if button_down? Gosu::KbUp or button_down? Gosu::GpUp then
       @piece.rotate_right
     end
     if @piece.y < Grid::GRID_BOTTOM
       @piece.move
     else
       @grid.fit_to_grid(@piece)
       @piece = Piece.new(self, @grid)
     end
  end

  def draw
    @background_image.draw(0,0,0);
    @piece.draw
    @grid.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
