# encoding: utf-8
require_relative("../chess.rb")


class Queen < Piece
  include SlidingPiece

  DIRECTIONS = [
    [-1, -1], [-1, 0], [-1, 1],

    [0, -1],           [0, 1],

    [1, -1],  [1, 0],  [1, 1] ]


  def render
    self.black? ? " ♛ " : " ♕ "
  end
end
