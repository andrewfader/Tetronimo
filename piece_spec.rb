require 'gosu'
require './piece'
describe Piece do
  describe "#shape" do
    [:I,:J,:L,:O,:S,:T,:Z].each do |shape|
      subject { Piece.set_shape(shape) }
      it "should be hash of nested arrays" do
        hash = subject
        -> { hash.is_a? Hash }.should be_true
        -> { hash[0].is_a? Array }.should be_true
        -> { hash[0][0].is_a? Array }.should be_true
      end
    end

    it "I" do
      Piece.set_shape(:I)[0].should == [[1,0],[2,0],[3,0]]
      Piece.set_shape(:I)[1].should == [[0,-1],[0,-2],[0,-3]]
      Piece.set_shape(:I)[2].should == [[-1,0],[-2,0],[-3,0]]
      Piece.set_shape(:I)[3].should == [[0,1],[0,2],[0,3]]
    end

    it "J" do
      Piece.set_shape(:J)[0].should == [[1,0],[2,0],[2,-1]]
      Piece.set_shape(:J)[1].should == [[0,-1],[0,-2],[-1,-2]]
      Piece.set_shape(:J)[2].should == [[-1,0],[-2,0],[-2,1]]
      Piece.set_shape(:J)[3].should == [[0,1],[0,2],[1,2]]
    end

    it "L" do
      Piece.set_shape(:L)[0].should == [[1,0],[2,0],[2,-1]]
      Piece.set_shape(:L)[1].should == [[0,-1],[0,-2],[-1,-2]]
      Piece.set_shape(:L)[2].should == [[-1,0],[-2,0],[-2,1]]
      Piece.set_shape(:L)[3].should == [[0,1],[0,2],[1,2]]
    end

    it "O" do
      (1..3).to_a.each do |index|
        Piece.set_shape(:O)[index].should == [[0,1],[1,1],[1,0]]
      end
    end

    it "S" do
      Piece.set_shape(:S)[0].should == [[1,0],[0,-1],[-1,-1]]
      Piece.set_shape(:S)[1].should == [[0,-1],[1,-1],[1,-2]]
      Piece.set_shape(:S)[2].should == [[1,0],[0,-1],[-1,-1]]
      Piece.set_shape(:S)[3].should == [[0,-1],[1,-1],[1,-2]]
    end

    it "T" do
      Piece.set_shape(:T)[0].should == [[-1,0],[1,0],[0,-1]]
      Piece.set_shape(:T)[1].should == [[0,-1],[0,1],[-1,0]]
      Piece.set_shape(:T)[2].should == [[1,0],[-1,0],[0,1]]
      Piece.set_shape(:T)[3].should == [[0,1],[0,-1],[1,0]]
    end

    it "Z" do
      Piece.set_shape(:Z)[0].should == [[-1,0],[-1,-1],[-2,-1]]
      Piece.set_shape(:Z)[1].should == [[0,1],[1,1],[1,2]]
      Piece.set_shape(:Z)[2].should == [[-1,0],[-1,-1],[-2,-1]]
      Piece.set_shape(:Z)[3].should == [[0,1],[1,1],[1,2]]
    end
  end
end
