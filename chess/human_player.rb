require_relative('chess.rb')

class HumanPlayer

  attr_reader :piece_color
  
  def initialize(name, piece_color)
    @name = name
    @piece_color = piece_color
  end

  def move_coordinates(board)
    get_input
  end

  def get_input
    puts "Which square would you like to move from?"
    start_pos = gets.chomp.split(",").map(&:to_i)
    puts "Which square would you like to move to?"
    end_pos = gets.chomp.split(",").map(&:to_i)

    [start_pos, end_pos]
  end

end
