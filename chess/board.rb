# encoding: utf-8
require "colorize"
require_relative("chess.rb")

class Board

  attr_reader :board

  def initialize(empty = false)
    @board = board = Array.new(8) { Array.new(8) }
    fill_new_game unless empty
  end

  def dup
    new_board = Board.new(true)

    self.each_pos do |piece|
      next if piece.nil?

      new_board[piece.coordinates] = piece.class.new(new_board, piece.color, piece.coordinates.dup)
    end
    new_board
  end

  def fill_new_game

    @board.length.times do |column|
      self[[1,column]] = Pawn.new(self,:black, [1, column])
      self[[6,column]] = Pawn.new(self,:white, [6, column])

      if column == 0 || column == 7
        self[[0,column]] = Rook.new(self, :black, [0, column])
        self[[7,column]] = Rook.new(self, :white, [7, column])

      elsif column == 1 || column == 6
        self[[0,column]] = Knight.new(self, :black, [0, column])
        self[[7,column]] = Knight.new(self, :white, [7, column])

      elsif column == 2 || column == 5
        self[[0,column]] = Bishop.new(self, :black, [0, column])
        self[[7,column]] = Bishop.new(self, :white, [7, column])

      elsif column == 3
        self[[0,column]] = Queen.new(self, :black, [0, column])
        self[[7,column]] = Queen.new(self, :white, [7, column])

      else
        self[[0,column]] = King.new(self, :black, [0, column])
        self[[7,column]] = King.new(self, :white, [7, column])
      end

    end

  end


  def render
    tile_count = 0

    @board.map do |row|
      tile_count += 1

      row.map do |pos|
        tile_count += 1

        string = pos.nil? ? " " : pos.render
        tile_count.odd? ? string.colorize(background: :green) : string
      end.join("")
    end
  end

  def display
    puts render
  end

  def move!(start, end_pos)
    piece = self[*start]

    if piece.nil?
      raise ArgumentError.new "There is no piece at your start coordinate."
    elsif !piece.moves.include?(end_pos)
      raise ArgumentError.new "Not a valid move, change your end position."

    else
      self[start] = nil
      self[end_pos] = piece
      piece.coordinates = end_pos
    end

    nil
  end

  def move(start, end_pos)
    piece = self[*start]
    
    if piece.nil?
      raise ArgumentError.new "There is no piece at your start coordinate."
    elsif !piece.valid_moves.include?(end_pos)
      raise ArgumentError.new "Not a valid move, change your end position."

    else
      move!(start,end_pos)
    end
    nil
  end

  def in_check?(color)
    kings_position = nil

    each_pos do |pos|
      if pos.is_a?(King) && pos.color == color
        kings_position = pos.coordinates
        break
      end
    end

    kings_position

    each_pos do |pos|
      if !pos.nil? && pos.color != color
        return true if pos.moves.include?(kings_position)
      end
    end

    false
  end

  def each_pos(&prc)
    @board.each do |row|
      row.each do |value|
        prc.call(value)
      end
    end
  end

  ####THIS COULD BE REFACTORED TO MAKE SURE THEY ARE CONSISTENT INPUT FORMATS!!!
  #*!*!*!*!*!*!**!*!
  def [](y,x)
    @board[y][x]
  end

  def []=(pos, value)
    y, x = pos
    @board[y][x] = value
  end






  def checkmate?(color)

  end

  def string
    puts "string".colorize(background: :green)
  end

end
