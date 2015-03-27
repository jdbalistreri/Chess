require ("dispel")
require_relative ("chess.rb")

class ChessConsole
  attr_reader :square_selected, :highlighted_positions

  def initialize
    @game = Game.new
    @square_selected = false
  end

  def draw_board
    display_strings = default_board
    if @game.board.game_over?
      display_strings << "Checkmate!"
      display_strings << "Play Again? Y/N."
    elsif @game.in_check?
      display_strings << "Check!"
    end
    5.times { display_strings << "" }
    display_strings.join("\n")
  end

  def start_board
    display_strings = default_board
    10.times { display_strings << "" }
    display_strings << "Use arrow keys to move and [enter] to select."
    display_strings.join("\n")
  end

  def default_board
    display_strings = @game.board.render(false)
    display_strings << "#{@game.current_player.piece_color.to_s.capitalize}'s Move."
    display_strings[0] = display_strings[0] + " " + @game.board.black_graveyard_other.join(" ")
    display_strings[1] = display_strings[1] + " " + @game.board.black_graveyard_pawns.join(" ")
    display_strings[6] = display_strings[6] + " " + @game.board.white_graveyard_other.join(" ")
    display_strings[7] = display_strings[7] + " " + @game.board.white_graveyard_pawns.join(" ")
    display_strings
  end

  def run
    @game.dispel_play

    y, x = 3, 4

    Dispel::Screen.open(:colors => true) do |screen|
      screen.draw(start_board, map, [y,x])

      Dispel::Keyboard.output do |key|


          case key
          when :"Ctrl+c" then break
          when :left then x -= 3 unless x <= 4
          when :right then x += 3 unless x >=24
          when :up then y -= 1 unless y <= 0
          when :down then y += 1 unless y >= 7
          when :enter then process_move(y,x)
          when "y" then @game = Game.new if @game.board.game_over?
          when "n" then break if @game.board.game_over?
          else @game.handle_dispel_move(*@game.current_player.move_coordinates) if @game.current_player.is_a?(ComputerPlayer)
          end

        screen.draw(draw_board, map, [y,x])
      end
    end
  end

  def map
    output = Dispel::StyleMap.new(8)
    (0..7).each do |line|
      (0..7).each do |row|
        output.add(["#000000", "#63bf5a"], line, (row*3+3)..(row*3+5) ) if (line + row).odd?
        output.add(["#000000", "#FFFFEE"], line, (row*3+3)..(row*3+5) ) if (line + row).even?
      end

      if @square_selected
        @highlighted_positions.each do |(y,x)|
          output.add(["#000000", "#70B8FF"], y, (x-1)..(x+1) )
        end
        output.add(["#000000", "#70B8FF"], @selected_y, (@selected_x-1)..(@selected_x+1) )
      end
    end
    output
  end


  def process_move(disp_y,disp_x)
    toggle_select

    if @square_selected
      @start_pos = parse_from_display([disp_y,disp_x])
      @game.validate_start(@start_pos)

      @highlighted_positions = [[disp_y,disp_x]]
      other_positions = @game.board[@start_pos].valid_moves.map do |pos|
        parse_to_display(pos)
      end

      @highlighted_positions += other_positions

      @selected_x = disp_x
      @selected_y = disp_y
    else
      @end_pos = parse_from_display([disp_y,disp_x])
      @game.handle_dispel_move(@start_pos, @end_pos)
    end

  rescue ArgumentError => e
    @square_selected = false
  end

  def parse_from_display(pos)
    y, x = pos
    [y,(x-4)/3]
  end

  def parse_to_display(pos)
    y, x = pos
    [y,x*3 + 4]
  end


  def toggle_select
    @square_selected = !@square_selected
  end

end
