# encoding: utf-8
require_relative("../chess.rb")

module SteppingPiece

  private
    def generate_deltas
      return @generated_deltas if @generated_deltas
      @generated_deltas = []
      curr_y, curr_x = @coordinates

      self.class::DELTAS.each do |(dy, dx)|
        new_y, new_x = curr_y + dy, curr_x + dx

        next unless on_the_board?([new_y, new_x])
        @generated_deltas << [new_y, new_x]
      end

      @generated_deltas
    end

end
