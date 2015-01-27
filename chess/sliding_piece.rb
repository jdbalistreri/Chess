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
        unless [curr_y, curr_x].any? {|el| el.between?(0,7)}

      end

      
    end
    # self.class::DELTAS.each do |(dy, dx)|
    #   new_y, new_x = curr_y + dy, curr_x + dx
    #   next if [new_y, new_x].any? { |coord| !coord.between?(0,7) }
    #
    #   possible_moves << [new_y, new_x]
    # end

    possible_moves
  end

end
