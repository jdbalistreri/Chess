# encoding: utf-8
require_relative("../chess.rb")


class Bishop < Piece
  include SlidingPiece

  DIRECTIONS = [
    [-1, -1],           [-1, 1],


    [1, -1],            [1, 1] ]

  def render
    self.is?(:black) ? " ♝ " : " ♗ "
  end

end
