require 'gosu'
require './piece'
describe Piece do
  describe "#shape" do
    subject { Piece.new(Gosu::Window.new(1024,960,false)).shape }
    it "should be hash of nested arrays" do
      hash = subject
      -> { hash.is_a? Hash }.should be_true
      -> { hash[0].is_a? Array }.should be_true
      -> { hash[0][0].is_a? Array }.should be_true
    end
  end
end
