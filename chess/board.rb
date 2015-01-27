# encoding: utf-8
require_relative("chess.rb")

class Board

  attr_reader :board

  def initialize
    @board = board = Array.new(8) { Array.new(8) }
    fill_new_game
  end


  def fill_new_game

    @board.length.times do |column|
      self[1,column] = Pawn.new(self,:black, [1, column])
      self[6,column] = Pawn.new(self,:white, [6, column])

      if column == 0 || column == 7
        self[0,column] = Rook.new(self, :black, [0, column])
        self[7,column] = Rook.new(self, :white, [7, column])

      elsif column == 1 || column == 6
        self[0,column] = Knight.new(self, :black, [0, column])
        self[7,column] = Knight.new(self, :white, [7, column])

      elsif column == 2 || column == 5
        self[0,column] = Bishop.new(self, :black, [0, column])
        self[7,column] = Bishop.new(self, :white, [7, column])

      elsif column == 3
        self[0,column] = Queen.new(self, :black, [0, column])
        self[7,column] = Queen.new(self, :white, [7, column])

      else
        self[0,column] = King.new(self, :black, [0, column])
        self[7,column] = King.new(self, :white, [7, column])
      end

    end

  end








  def [](y,x)
    @board[y][x]
  end

  def []=(pos, value)
    y, x = pos
    @board[y][x] = value
  end

  def in_check?(color)

  end

  def move(start, end_pos)
  #raise exception if no piece at the start pos and if piece can't move to end pos
  end

  def dup
    #creates a current copy of the board
  end

  def checkmate?(color)

  end

end
