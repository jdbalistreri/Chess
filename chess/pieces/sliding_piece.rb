# encoding: utf-8
require_relative("../chess.rb")

module SlidingPiece

  private
    def generate_deltas
      generated_deltas = []

      self.class::DIRECTIONS.each do |(dy, dx)|
        curr_y, curr_x = self.coordinates

        loop do
          curr_y, curr_x  = curr_y + dy, curr_x + dx

          break unless on_the_board?([curr_y, curr_x])
          generated_deltas << [curr_y, curr_x]

          break unless empty_spot?([curr_y, curr_x])
        end
      end

      generated_deltas
    end

end
