require_relative("chess.rb")

class Piece
  attr_reader :color

  def initialize(board, color, coordinates)
    @board = board
    @color = color
    @coordinates = coordinates
  end

  def check_deltas_against_board(possible_moves)
    possible_moves.select do |pos|
      pos_value = @board[*pos]
      pos_value.nil? || !(pos_value.color == @color)
    end
  end

  def moves
    
  end

  def move_into_check?(pos)

  end

  def render

  end

end
