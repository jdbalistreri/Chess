require_relative("chess.rb")


class Knight < SteppingPiece

  DELTAS = [[2,1],
          [2,-1],
          [-2,1],
          [-2,-1],
          [1,2],
          [1,-2],
          [-1,2],
          [-1,-2]]

end
