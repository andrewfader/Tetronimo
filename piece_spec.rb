require 'gosu'
require './piece'
require './game_window'
require './grid'
describe Piece do
  describe "#shape" do
    let(:window) { GameWindow.new }
    let(:grid) { Grid.new(window) }
    let(:piece) { Piece.new(window, grid, type) }

    context "I" do
      let(:type) { :I }
      it "rotates" do
        piece.shape.should == [[1,0],[2,0],[3,0]]
        piece.rotate
        piece.shape.should == [[0,-1],[0,-2],[0,-3]]
        piece.rotate
        piece.shape.should == [[-1,0],[-2,0],[-3,0]]
        piece.rotate
        piece.shape.should == [[0,1],[0,2],[0,3]]
      end
    end

    context "J" do
      let(:type) { :J }
      it "rotates" do
        piece.shape.should == [[1,0],[2,0],[2,-1]]
        piece.rotate
        piece.shape.should == [[0,-1],[0,-2],[-1,-2]]
        piece.rotate
        piece.shape.should == [[-1,0],[-2,0],[-2,1]]
        piece.rotate
        piece.shape.should == [[0,1],[0,2],[1,2]]
      end
    end

    context "L" do
      let(:type) { :L }
      it "rotates" do
        piece.shape.should == [[1,0],[2,0],[2,-1]]
        piece.rotate
        piece.shape.should == [[0,-1],[0,-2],[-1,-2]]
        piece.rotate
        piece.shape.should == [[-1,0],[-2,0],[-2,1]]
        piece.rotate
        piece.shape.should == [[0,1],[0,2],[1,2]]
      end
    end

    # context "O" do
      # let(:type) { :O }
      # it "rotates" do
        # piece.shape.should == [[0,1],[1,1],[1,0]]
        # piece.rotate
        # piece.shape.should == [[0,1],[1,1],[1,0]]
        # piece.rotate
        # piece.shape.should == [[0,1],[1,1],[1,0]]
        # piece.rotate
        # piece.shape.should == [[0,1],[1,1],[1,0]]
      # end
    # end

    # context "S" do
      # let(:type) { :S }
      # it "rotates" do
        # piece.shape.should == [[1,0],[0,-1],[-1,-1]]
        # piece.rotate
        # piece.shape.should == [[0,-1],[1,-1],[1,-2]]
        # piece.rotate
        # piece.shape.should == [[1,0],[0,-1],[-1,-1]]
        # piece.rotate
        # piece.shape.should == [[0,-1],[1,-1],[1,-2]]
      # end
    # end

    # context "T" do
      # let(:type) { :T }
      # it "rotates" do
        # piece.shape.should == [[-1,0],[1,0],[0,-1]]
        # piece.rotate
        # piece.shape.should == [[0,-1],[0,1],[-1,0]]
        # piece.rotate
        # piece.shape.should == [[1,0],[-1,0],[0,1]]
        # piece.rotate
        # piece.shape.should == [[0,1],[0,-1],[1,0]]
      # end
    # end

    # context "Z" do
      # let(:type) { :Z }
      # it "rotates" do
        # piece.shape.should == [[-1,0],[-1,-1],[-2,-1]]
        # piece.rotate
        # piece.shape.should == [[0,1],[1,1],[1,2]]
        # piece.rotate
        # piece.shape.should == [[-1,0],[-1,-1],[-2,-1]]
        # piece.rotate
        # piece.shape.should == [[0,1],[1,1],[1,2]]
      # end
    # end
  end
end
