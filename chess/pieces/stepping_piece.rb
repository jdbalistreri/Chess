# encoding: utf-8
require_relative("../chess.rb")

module SteppingPiece

  def moves
    super(generate_deltas)
  end

  def generate_deltas
    possible_moves = []
    curr_y, curr_x = @coordinates

    self.class::DELTAS.each do |(dy, dx)|
      new_y, new_x = curr_y + dy, curr_x + dx
      next unless on_the_board?([new_y, new_x])

      possible_moves << [new_y, new_x]
    end

    possible_moves
  end

end
