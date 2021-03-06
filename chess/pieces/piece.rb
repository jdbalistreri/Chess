# encoding: utf-8
require_relative("../chess.rb")
require 'byebug'

class Piece
  attr_accessor :coordinates, :value, :board, :generated_deltas, :traditional_moves
  attr_reader :color

  def initialize(board, color, coordinates)
    @board, @color, @coordinates = board, color, coordinates
  end

  def valid_moves(moves = self.moves)
    moves.select do |move|
      board_clone = self.board.dup
      board_clone.move!(self.coordinates, move)

      !board_clone.in_check?(self.color)
    end
  end

  def moves
    generate_deltas.select do |pos|
      empty_spot?(pos) || opposing_piece?(pos)
    end
  end

  # UTILITY METHODS
  def opposing_piece?(pos)
    return false if empty_spot?(pos)
    piece = self.board[pos]
    self.is?(:white) ? piece.is?(:black) : piece.is?(:white)
  end

  def empty_spot?(pos)
    self.board[pos].nil?
  end

  def on_the_board?(pos)
    pos.all? { |el| el.between?(0,7) }
  end

  def is?(color)
    self.color == color
  end

  def post_move_callback

  end

end
