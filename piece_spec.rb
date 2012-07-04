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
  end
end
