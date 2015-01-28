require_relative('chess.rb')

class Game

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new("Karthik", :white)
    @player2 = HumanPlayer.new("Joe", :black)
  end

  def play
    @current_player = @player1

    until @board.game_over?
      @board.display

      begin
        start_pos, end_pos = @current_player.move_coordinates(@board)

        @board.move(start_pos, end_pos)
      rescue ArgumentError => e
        puts e
        retry
      end

      toggle_player
    end


  end

  def toggle_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end


end
