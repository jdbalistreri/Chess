# encoding: utf-8
require_relative("../chess.rb")


class Rook < Piece
  include SlidingPiece

  DIRECTIONS = [
              [-1, 0],

    [0, -1],           [0, 1],

              [1, 0]]



  def render
    @color == :black ? " ♜ " : " ♖ "
  end
end
