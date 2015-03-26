# encoding: utf-8
require_relative("../chess.rb")

class Piece
  attr_accessor :coordinates, :value
  attr_reader :color

  PIECE_VALUES = { Pawn: 1,
                   Knight: 3,
                   Bishop: 3,
                   Rook: 5,
                   Rook: 5,
                   Queen: 9 }

  def initialize(board, color, coordinates)
    @board, @color, @coordinates = board, color, coordinates
    @value = PIECE_VALUES[self.class.to_s.to_sym]
  end

  def valid_moves
    self.moves.select do |move|
      board_clone = @board.dup
      board_clone.move!(coordinates,move)

      !board_clone.in_check?(self.color)
    end
  end

  def moves(generated_deltas)
    generated_deltas.select do |pos|
      empty_spot?(pos) || opposing_piece?(pos)
    end
  end

  # UTILITY METHODS
  def white?
    self.color == :white
  end

  def black?
    self.color == :black
  end

  def opposing_piece?(pos)
    return false if empty_spot?(pos)
    piece = @board[pos]
    self.white? ? piece.black? : piece.white?
  end

  def empty_spot?(pos)
    @board[pos].nil?
  end

  def on_the_board?(pos)
    pos.all? { |el| el.between?(0,7) }
  end
end
