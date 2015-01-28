require ("dispel")
require_relative ("chess.rb")

class ChessConsole
  def initialize
    @game = Game.new
    @board = @game.board
    @square_selected = false
  end

  def draw_board
    @board.render(false).join("\n")
  end

  def run

    y, x = 3, 4

    Dispel::Screen.open(:colors => true) do |screen|
       # number of lines


      screen.draw(draw_board, map, [y,x])

      #Dispel::Keyboard.output { break }

      Dispel::Keyboard.output do |key|
        case key
        when :"Ctrl+c" then break
        when :left then x -= 3
        when :right then x += 3
        when :up then y -= 1
        when :down then y += 1
        when :enter then process_move(y,x)
        end
        screen.draw(draw_board, map, [y,x])
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
        # @highlighted_positions.each do |(y,x)|
        #   output.add(["#000000", "#70B8FF"], y, (x-1)..(x+1) )
        # end
        output.add(["#000000", "#70B8FF"], @selected_y, (@selected_x-1)..(@selected_x+1) )
      end
    end
    output
  end


  def process_move(y,x)
    toggle_select

    if @square_selected
      @start_pos = parse_from_display(y,x)
      @board.check_start(@start_pos, :white)

      @highlighted_positions = [[y,x]]
      # other_positions = @board[*@start_pos].valid_moves.map do |pos|
      #   parse_to_display(pos)
      # end

      #@highlighted_positions << other_positions

      @selected_x = x
      @selected_y = y
    else
      @end_pos = parse_from_display(y,x)
      @board.move(@start_pos, @end_pos, :white)
    end

  # rescue ArgumentError => e
    #do something with the error
    # @square_selected = false
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
