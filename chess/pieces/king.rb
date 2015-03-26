# encoding: utf-8
require_relative("../chess.rb")



class King < Piece
  include SteppingPiece

  DELTAS = [
    [-1, -1], [-1, 0], [-1, 1],

    [0, -1],           [0, 1],

    [1, -1],  [1, 0],  [1, 1] ]

  def render
    self.is?(:black) ? " ♚ " : " ♔ "
  end

end
