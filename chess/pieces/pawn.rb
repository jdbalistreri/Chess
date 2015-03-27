# encoding: utf-8
require_relative("../chess.rb")
require 'byebug'

class Pawn < Piece

  def initialize(board, color, coordinates)
    super

    @dy = self.is?(:black) ? 1 : -1
    @start_row = self.is?(:black) ? 1 : 6
  end

  def moves
    possible_moves = []

    curr_y, curr_x = @coordinates

    one_move_ahead = [curr_y + @dy, curr_x]
    two_moves_ahead = [curr_y + (@dy * 2), curr_x]
    first_diag = [curr_y + @dy, curr_x + 1]
    second_diag = [curr_y + @dy, curr_x - 1]

    possible_moves << first_diag if on_the_board?(first_diag) && opposing_piece?(first_diag)
    possible_moves << second_diag if on_the_board?(second_diag) && opposing_piece?(second_diag)

    if on_the_board?(one_move_ahead) && empty_spot?(one_move_ahead)
      possible_moves << one_move_ahead

      if curr_y == @start_row && empty_spot?(two_moves_ahead)
        possible_moves << two_moves_ahead
      end
    end

    possible_moves
  end

  def render
    self.is?(:black) ? " ♟ " : " ♙ "
  end

  def post_move_callback
    check_for_promotion
  end

  def check_for_promotion
    curr_y = self.coordinates[0]
    back_row = self.is?(:black) ? 7 : 0

    if curr_y == back_row
      self.board.promote_pawn(self)
    end
  end
end
