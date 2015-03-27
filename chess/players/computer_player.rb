require_relative("../chess.rb")

class ComputerPlayer

  attr_reader :piece_color

  def initialize(name, piece_color, board)
    @name = name
    @piece_color = piece_color
    @board = board
  end

  def move_coordinates
    random_move
  end

  def random_move
    pieces = @board.pieces.select { |piece| piece.is?(self.piece_color) }
    loop do
      valid_pieces = pieces.select { |piece| !piece.valid_moves.empty? }
      piece = valid_pieces.sample
      return [piece.coordinates, piece.valid_moves.sample]
    end
  end

end
