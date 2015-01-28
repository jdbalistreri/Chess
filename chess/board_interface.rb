require ("dispel")
require_relative ("chess.rb")

class ChessConsole
  attr_reader :square_selected, :highlighted_positions

  def initialize
    @game = Game.new
    @board = @game.board
    @square_selected = false
  end

  def draw_board
    @board.render(false).join("\n")
  end

  def run
    @game.dispel_play

    y, x = 3, 4

    Dispel::Screen.open(:colors => true) do |screen|
      screen.draw(draw_board, map, [y,x])

      Dispel::Keyboard.output do |key|
        case key
        when :"Ctrl+c" then break
        when :left then x -= 3 unless x <= 4
        when :right then x += 3 unless x >=24
        when :up then y -= 1 unless y <= 0
        when :down then y += 1 unless y >= 7
        when :enter then process_move(y,x)
        end

        screen.draw(draw_board, map, [y,x])
        break if @board.game_over?
      end
    end
  end

  def map
    output = Dispel::StyleMap.new(9)
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
      @start_pos = parse_from_display(disp_y,disp_x)
      @game.check_start(@start_pos)

      @highlighted_positions = [[disp_y,disp_x]]
      other_positions = @board[*@start_pos].valid_moves.map do |pos|
        parse_to_display(*pos)
      end

      @highlighted_positions += other_positions

      @selected_x = disp_x
      @selected_y = disp_y
    else
      @end_pos = parse_from_display(disp_y,disp_x)
      @game.handle_dispel_move(@start_pos, @end_pos)
    end

  rescue ArgumentError => e
    # puts e
    @square_selected = false
  end

  def parse_from_display(y,x)
    [y,(x-4)/3]
  end

  def parse_to_display(y,x)
    [y,x*3 + 4]
  end


  def toggle_select
    @square_selected = !@square_selected
  end

end



if __FILE__ == $PROGRAM_NAME
  console = ChessConsole.new
  console.run
  puts "Hi"
end
