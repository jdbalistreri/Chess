# encoding: utf-8
require_relative("../chess.rb")


class Bishop < Piece
  include SlidingPiece

  DIRECTIONS = [
    [-1, -1],           [-1, 1],


    [1, -1],            [1, 1] ]

  def render
    @color == :black ? " ♝ " : " ♗ "
  end

end
