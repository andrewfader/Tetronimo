require 'rubygems'
require 'gosu'
require './piece'
class GameWindow < Gosu::Window
  attr_accessor :piece
  def initialize
    super 1024, 960, false, 48
    self.caption = "Tetronimo"

    @background_image = Gosu::Image.new(self, "bg.png", true)
    @menu = Gosu::Image.new(self, "menu.png", true)
    @game_start = false
  end

  def update
    if @game_start
      if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
        @piece.move_left
      end
      if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
        @piece.move_right
      end
      if button_down? Gosu::KbDown or button_down? Gosu::GpDown then
        @piece.drop_faster
      end
    else
      if button_down? Gosu::KbEnter or button_down? Gosu::KbReturn then
        @game_start = true
        @grid = Grid.new(self)
        @piece = Piece.new(self, @grid)
      end
    end
  end

  def button_up(id)
    if @game_start
      case id
      when Gosu::KbUp, Gosu::GpUp
        @piece.rotate_right
        @piece.draw
      end
    end
  end

  def draw
    if @game_start
      if @piece.y < Grid::GRID_BOTTOM
        @piece.move
      else
        @grid.fit_to_grid(@piece)
        @grid.check_for_lines
        @piece = Piece.new(self, @grid)
      end
      @background_image.draw(0,0,0);
      @piece.draw
      @grid.draw
    else
      @menu.draw(0,0,0)
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def gameover
    @game_start = false
  end
end

window = GameWindow.new
window.show
