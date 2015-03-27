# encoding: utf-8
require_relative("../chess.rb")


class Rook < Piece
  include SlidingPiece

  attr_reader :can_castle

  DIRECTIONS = [
              [-1, 0],

    [0, -1],           [0, 1],

              [1, 0]]


  def initialize(board, color, coordinates)
    super
    @can_castle = true
  end

  def render
    self.is?(:black) ? " ♜ " : " ♖ "
  end

  def post_move_callback
    @can_castle = false
  end
end
