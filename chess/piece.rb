# encoding: utf-8
require_relative("chess.rb")

class Piece
  attr_accessor :coordinates
  attr_reader :color

  def initialize(board = nil, color = nil, coordinates = nil)
    @board = board || Board.new
    @color = color || :white
    @coordinates = coordinates || [4,4]
  end

  def inspect
    "#{self.color.to_s.capitalize} #{self.class.to_s.capitalize}"
  end

  def valid_moves
    self.moves.select do |move|
      board_clone = @board.dup
      board_clone.move!(coordinates,move)

      !board_clone.in_check?(color)
    end
  end

  def moves(possible_moves)
    prune_moves(possible_moves)
  end

  def prune_moves(possible_moves)
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

  def move_into_check?(pos)

  end

end
