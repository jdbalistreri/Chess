require_relative("chess.rb")

class SteppingPiece < Piece

  def initialize(board, color, coordinates)
    super
  end

  def moves(move_positions) #this will slide in each direction until invalid move
    #make sure we can take the opponent's piece
  end

  def check_deltas_against_board

  end

end
