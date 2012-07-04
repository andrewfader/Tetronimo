require 'rubygems'
require 'gosu'
require './piece'
class GameWindow < Gosu::Window
  def initialize
    super 1024, 960, false
    self.caption = "Tetronimo"

    @background_image = Gosu::Image.new(self, "bg.png", true)
    @piece = Piece.new(self)
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
     if @piece.y < 800
       @piece.move
     else
       @piece = Piece.new(self)
     end
  end

  def draw
    @background_image.draw(0,0,0);
    @piece.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
