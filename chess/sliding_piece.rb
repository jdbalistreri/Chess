# encoding: utf-8
require_relative("chess.rb")

class SlidingPiece < Piece

  def moves
    super(generate_deltas)
  end

  def generate_deltas
    possible_moves = []

    self.class::DIRECTIONS.each do |(dy, dx)|
      curr_y, curr_x = @coordinates

      loop do
        curr_y, curr_x  = curr_y + dy, curr_x + dx
        break if [curr_y, curr_x].any? {|el| !el.between?(0,7)}

        possible_moves << [curr_y, curr_x]
        break if !@board[curr_y, curr_x].nil?
      end
    end

    possible_moves
  end

end
