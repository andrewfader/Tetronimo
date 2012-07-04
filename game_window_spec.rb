require './game_window'
require './piece'
describe GameWindow do
  describe "#initialize" do
    subject { GameWindow.new }
    its(:caption) { should == "Tetronimo" }
  end
end
