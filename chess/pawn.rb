# encoding: utf-8
require_relative("chess.rb")


class Pawn < Piece

  def initialize(board, color, coordinates)
    super

    @dy = color == :black ? 1 : -1
    @start_row = color == :black ? 1 : 6
  end

  def moves
    possible_moves = []

    curr_y, curr_x = @coordinates

    one_move_ahead = [curr_y + @dy, curr_x]
    two_moves_ahead = [curr_y + (@dy * 2), curr_x]
    first_diag = [curr_y + @dy, curr_x + 1]
    second_diag = [curr_y + @dy, curr_x - 1]

    possible_moves << first_diag if opposing_piece?(*first_diag)
    possible_moves << second_diag if opposing_piece?(*second_diag)

    possible_moves << one_move_ahead if empty_spot?(*one_move_ahead)

    if empty_spot?(*two_moves_ahead) && curr_y == @start_row
      possible_moves << two_moves_ahead
    end

    possible_moves
  end

end

#♙ white pawn
#♟ black pawn
