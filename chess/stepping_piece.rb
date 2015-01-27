require_relative("chess.rb")

class SteppingPiece < Piece

  def initialize(board, color, coordinates)
    super
  end

  def moves(possible_moves) #this will slide in each direction until invalid move
    check_deltas_against_board(possible_moves)
  end

  def check_deltas_against_board(possible_moves)
    possible_moves.select do |pos|
      pos_contains = @board[*pos]
      if pos_contains.nil?
        true
      elsif pos_contains.color
    end
  end

end
