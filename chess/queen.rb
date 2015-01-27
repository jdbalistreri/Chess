require_relative("chess.rb")


class Queen < SlidingPiece

  DIRECTIONS = [
    [-1, -1], [-1, 0], [-1, 1],

    [0, -1],           [0, 1],

    [1, -1],  [1, 0],  [1, 1] ]

    
end
