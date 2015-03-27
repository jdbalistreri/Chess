# encoding: utf-8
require_relative("../chess.rb")
require 'byebug'


class King < Piece
  include SteppingPiece

  attr_reader :can_castle

  DELTAS = [
    [-1, -1], [-1, 0], [-1, 1],

    [0, -1],           [0, 1],

    [1, -1],  [1, 0],  [1, 1] ]

  def initialize(board, color, coordinates)
    super
    @can_castle = true
    @start_row = self.is?(:black) ? 0 : 7
  end

  def render
    self.is?(:black) ? " ♚ " : " ♔ "
  end

  def generate_deltas
    deltas = DELTAS.dup
    if king_can_castle
      deltas << [0, -2] if left_castle_available
      deltas << [0, 2] if right_castle_available
    end
    super(deltas)
  end

  def left_castle_available
    left_rook_can_castle &&
      [1,2,3].all? { |x| self.board[[@start_row, x]].nil? }
  end

  def right_castle_available
    right_rook_can_castle &&
      [5,6].all? { |x| self.board[[@start_row, x]].nil? }
  end

  def left_rook_can_castle
    return @left_available if @left_available == false
    left_rook = self.board[[@start_row, 0]]
    @left_available = left_rook.is_a?(Rook) && left_rook.can_castle
  end

  def right_rook_can_castle
    return @right_available if @right_available == false
    right_rook = self.board[[@start_row, 7]]
    @right_available = right_rook && right_rook.can_castle
  end

  def king_can_castle
    self.can_castle &&
      !self.board.in_check?(self.color)
    #the king does not move through a square attacked by the opponent
    #the king cannot be in check after castling
  end

  def post_move_callback
    @can_castle = false
  end

end
