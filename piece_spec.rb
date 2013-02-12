require 'gosu'
require './piece'
require './game_window'
require './grid'
describe Piece do
  describe "#shape" do
    it "I" do
      window = GameWindow.new
      grid = Grid.new(window)
      piece = Piece.new(window, grid, :I)
      piece.shape.should == [[1,0],[2,0],[3,0]]
      piece.rotate_right
      piece.shape.should == [[0,-1],[0,-2],[0,-3]]
      piece.rotate_right
      piece.shape.should == [[-1,0],[-2,0],[-3,0]]
      piece.rotate_right
      piece.shape.should == [[0,1],[0,2],[0,3]]
    end

    # it "J" do
      # Piece.set_shape(:J,0).should == [[1,0],[2,0],[2,-1]]
      # Piece.set_shape(:J,1).should == [[0,-1],[0,-2],[-1,-2]]
      # Piece.set_shape(:J,2).should == [[-1,0],[-2,0],[-2,1]]
      # Piece.set_shape(:J,3).should == [[0,1],[0,2],[1,2]]
    # end

    # it "L" do
      # Piece.set_shape(:L,0).should == [[1,0],[2,0],[2,-1]]
      # Piece.set_shape(:L,1).should == [[0,-1],[0,-2],[-1,-2]]
      # Piece.set_shape(:L,2).should == [[-1,0],[-2,0],[-2,1]]
      # Piece.set_shape(:L,3).should == [[0,1],[0,2],[1,2]]
    # end

    # it "O" do
      # (1..3).to_a.each do |index|
        # Piece.set_shape(:O,index).should == [[0,1],[1,1],[1,0]]
      # end
    # end

    # it "S" do
      # Piece.set_shape(:S,0).should == [[1,0],[0,-1],[-1,-1]]
      # Piece.set_shape(:S,1).should == [[0,-1],[1,-1],[1,-2]]
      # Piece.set_shape(:S,2).should == [[1,0],[0,-1],[-1,-1]]
      # Piece.set_shape(:S,3).should == [[0,-1],[1,-1],[1,-2]]
    # end

    # it "T" do
      # Piece.set_shape(:T,0).should == [[-1,0],[1,0],[0,-1]]
      # Piece.set_shape(:T,1).should == [[0,-1],[0,1],[-1,0]]
      # Piece.set_shape(:T,2).should == [[1,0],[-1,0],[0,1]]
      # Piece.set_shape(:T,3).should == [[0,1],[0,-1],[1,0]]
    # end

    # it "Z" do
      # Piece.set_shape(:Z,0).should == [[-1,0],[-1,-1],[-2,-1]]
      # Piece.set_shape(:Z,1).should == [[0,1],[1,1],[1,2]]
      # Piece.set_shape(:Z,2).should == [[-1,0],[-1,-1],[-2,-1]]
      # Piece.set_shape(:Z,3).should == [[0,1],[1,1],[1,2]]
    # end
  end
end
