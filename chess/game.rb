require_relative('chess.rb')

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new("Karthik", :white)
    @player2 = HumanPlayer.new("Joe", :black)
  end

  def play
    @current_player = @player1

    until @board.game_over?
      @board.display
      puts "#{@current_player.piece_color.to_s.capitalize}'s turn"
      begin
        start_pos, end_pos = @current_player.move_coordinates(@board)

        @board.move(start_pos, end_pos, @current_player.piece_color)
      rescue ArgumentError => e
        puts e
        retry
      end

      toggle_player
    end

    toggle_player

    puts "Congratulations, #{@current_player.piece_color.to_s.capitalize} wins!"

  end

  def toggle_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end


end
