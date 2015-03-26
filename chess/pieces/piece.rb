# encoding: utf-8
require_relative("../chess.rb")

class Piece
  attr_accessor :coordinates, :value
  attr_reader :color

  PIECE_VALUES = { Pawn: 1,
                   Knight: 3,
                   Bishop: 3,
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

      !board_clone.in_check?(color)
    end
  end

  def moves(possible_moves)
    possible_moves.select do |pos|
      pos_value = @board[*pos]
      pos_value.nil? || !(pos_value.color == @color)
    end
  end

  def opposing_piece?(y, x)
    return false unless [y,x].all? { |el| el.between?(0,7) }
    piece = @board[y,x]
    !piece.nil? && piece.color != @color
  end

  def empty_spot?(y, x)
    return false unless [y,x].all? { |el| el.between?(0,7) }
    @board[y,x].nil?
  end

end
