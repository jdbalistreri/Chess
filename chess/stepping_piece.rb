# encoding: utf-8
require_relative("chess.rb")

class SteppingPiece < Piece

  def moves
    super(generate_deltas)
  end

  def generate_deltas
    possible_moves = []
    curr_y, curr_x = @coordinates

    self.class::DELTAS.each do |(dy, dx)|
      new_y, new_x = curr_y + dy, curr_x + dx
      next if [new_y, new_x].any? { |coord| !coord.between?(0,7) }

      possible_moves << [new_y, new_x]
    end

    possible_moves
  end

end
