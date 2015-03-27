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
    @start_row = coordinates[0]
  end

  def render
    self.is?(:black) ? " ♚ " : " ♔ "
  end

  def traditional_moves
    return @traditional_moves if @traditional_moves

    self.moves

    @traditional_moves
  end

  def castle_moves
    castle_moves = []

    if king_can_castle
      castle_moves << [@start_row, 2] if left_castle_available
      castle_moves << [@start_row, 6] if right_castle_available
    end

    castle_moves
  end

  def moves
    @traditional_moves = super
    @traditional_moves.concat(castle_moves)
  end

  def left_castle_available
    left_rook_can_castle &&
      [1,2,3].all? { |x| self.board[[@start_row, x]].nil? } &&
      !valid_moves([[@start_row, 3]]).empty?
  end

  def right_castle_available
    right_rook_can_castle &&
      [5,6].all? { |x| self.board[[@start_row, x]].nil? } &&
      !valid_moves([[@start_row, 5]]).empty?
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
    self.can_castle && true &&
       !self.board.in_check?(self.color)
  end

  def post_move_callback
    if @can_castle
      if self.coordinates[1] == 2
        @board.move!([@start_row, 0], [@start_row, 3])
      elsif self.coordinates[1] == 6
        @board.move!([@start_row, 7], [@start_row, 5])
      end
    end
    @can_castle = false
  end

end
