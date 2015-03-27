# encoding: utf-8
require "colorize"
require_relative("chess.rb")

class Board

  attr_reader :board, :graveyard

  def initialize(options = {})
    @graveyard = []
    create_game_board(options)
  end

  def move(start_pos, end_pos, player_color)
    piece = self[start_pos]
    validate_move(piece, end_pos)
    move!(start_pos, end_pos)

    piece.post_move_callback

    pieces.each do |piece|
      piece.generated_deltas = nil
      piece.traditional_moves = nil
    end
  end

  def move!(start_pos, end_pos)
    moving_piece = self[start_pos]
    taken_piece = self[end_pos]

    @graveyard << taken_piece if taken_piece

    self[start_pos], self[end_pos] = nil, moving_piece
    moving_piece.coordinates = end_pos
  end

  def game_over?
    checkmate?(:white) || checkmate?(:black)
  end

  def checkmate?(color)
    return false unless in_check?(color)

    pieces.select { |piece| piece.is?(color) }.each do |piece|
      return false unless piece.valid_moves.empty?
    end

    true
  end

  def in_check?(color)
    king = pieces.find { |piece| piece.is_a?(King) && piece.is?(color) }
    kings_position = king.coordinates

    pieces.select { |piece| !piece.is?(color) }.each do |piece|
      if piece.is_a?(King)
        return true if piece.traditional_moves.include?(kings_position)
      else
        return true if piece.moves.include?(kings_position)
      end
    end

    false
  end

  def dup
    new_board = Board.new({empty: true})

    pieces.each do |piece|
      new_board[piece.coordinates] = piece.class.new(new_board, piece.color, piece.coordinates.dup)
    end

    new_board
  end

  def validate_start(start_pos, player_color)
    if self[start_pos].nil?
      raise ArgumentError.new "You cannot move from an empty square."
    elsif self[start_pos].color != player_color
      raise ArgumentError.new "This is the wrong color piece."
    end
  end

  def promote_pawn(pawn)
    self[pawn.coordinates] = Queen.new(self, pawn.color, pawn.coordinates.dup)
  end

  #UTILITY METHODS
  def pieces
    all_pieces = @board.flatten.compact
  end

  def [](pos)
    y, x = pos
    @board[y][x]
  end

  def []=(pos, value)
    y, x = pos
    @board[y][x] = value
  end

  def display
    puts render
  end

  def render(colors = true)
    tile_count = 0
    row_num = 9

    board_array = @board.map do |row|
      tile_count += 1

      row_string = row.map do |pos|
        tile_count += 1

        string = pos.nil? ? "   " : pos.render
        if colors
          string = tile_count.odd? ? string.colorize(background: :green) : string.colorize(background: :white)
        end
        string
      end.join("")

      row_num -= 1

      "  #{row_num}#{row_string}"
    end

    board_array << "    #{("A".."H").to_a.join("  ")}"
  end

  def white_graveyard_pawns
    @graveyard.select { |piece| piece.is?(:white) && piece.is_a?(Pawn) }.map(&:render).map(&:strip)
  end

  def white_graveyard_other
    @graveyard.select { |piece| piece.is?(:white) && !piece.is_a?(Pawn) }.reverse.map(&:render).map(&:strip)
  end

  def black_graveyard_pawns
    @graveyard.select { |piece| piece.is?(:black) && piece.is_a?(Pawn) }.map(&:render).map(&:strip)
  end

  def black_graveyard_other
    @graveyard.select { |piece| piece.is?(:black) && !piece.is_a?(Pawn) }.reverse.map(&:render).map(&:strip)
  end

  private
    def validate_move(piece, end_pos)
      if piece.nil?
        raise ArgumentError.new "There is no piece at your start coordinate."
      elsif !piece.moves.include?(end_pos)
        raise ArgumentError.new "That piece is unable to move to your end position."
      elsif !piece.valid_moves.include?(end_pos)
        raise ArgumentError.new "Illegal move. You cannot leave/put your King in check."
      end
    end

    def create_game_board(options)
      @board = Array.new(8) { Array.new(8) }
      return if options[:empty]

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
end
