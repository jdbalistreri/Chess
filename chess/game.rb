require_relative('chess.rb')

class Game
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new("Player1", :white)
    @player2 = HumanPlayer.new("Player2", :black)
    @current_player = @player1
  end

  def terminal_play
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

  def dispel_play
    @current_player = @player1
  end

  def handle_dispel_move(start_pos, end_pos)
    begin
      @board.move(start_pos, end_pos, @current_player.piece_color)
    rescue ArgumentError => e
      toggle_player
    end
    toggle_player
    nil
  end

  def in_check?
    @board.in_check?(@current_player.piece_color)
  end

  def validate_start(start_pos)
    @board.validate_start(start_pos, @current_player.piece_color)
  end

  def toggle_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

end
