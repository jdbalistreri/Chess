# encoding: utf-8
require_relative("../chess.rb")
require 'byebug'

class Pawn < Piece

  attr_reader :moved

  def initialize(board, color, coordinates, moved = false)
    super(board, color, coordinates)

    @dy = self.is?(:black) ? 1 : -1
    @moved = moved
  end

  def moves
    @generated_deltas = generate_deltas
  end

  def generate_deltas
    @generated_deltas ||= []
    @en_passant_moves = @generated_deltas

    curr_y, curr_x = @coordinates

    one_move_ahead = [curr_y + @dy, curr_x]
    @two_moves_ahead ||= [curr_y + (@dy * 2), curr_x]
    first_diag = [curr_y + @dy, curr_x + 1]
    second_diag = [curr_y + @dy, curr_x - 1]

    generated_deltas << first_diag if on_the_board?(first_diag) && opposing_piece?(first_diag)
    generated_deltas << second_diag if on_the_board?(second_diag) && opposing_piece?(second_diag)

    if on_the_board?(one_move_ahead) && empty_spot?(one_move_ahead)
      generated_deltas << one_move_ahead

      if !@moved && empty_spot?(@two_moves_ahead)
        generated_deltas << @two_moves_ahead
      end
    end

    generated_deltas
  end

  def render
    self.is?(:black) ? " ♟ " : " ♙ "
  end

  def post_move_callback
    if !@moved
      grant_neighbors_en_passant if self.coordinates == @two_moves_ahead
    elsif @en_passant_moves.include?(self.coordinates)
      y, x = self.coordinates
      self.board[[y - @dy, x]] = nil
    else
      check_for_promotion
    end

    @moved = true
  end

  def grant_neighbors_en_passant
    curr_y, curr_x = self.coordinates
    neighbors = []

    neighbors << self.board[[curr_y, curr_x - 1]] if curr_x > 0
    neighbors << self.board[[curr_y, curr_x + 1]] if curr_x < 7

    neighbors.compact.each do |piece|
      piece.generated_deltas ||= [[curr_y - @dy, curr_x]] if piece.is_a?(Pawn)
    end
  end

  def check_for_promotion
    curr_y = self.coordinates[0]
    back_row = self.is?(:black) ? 7 : 0

    if curr_y == back_row
      self.board.promote_pawn(self)
    end
  end
end
