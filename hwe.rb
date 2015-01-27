class Game
  attr_reader :guesses_left, :known_letters

  def initialize(player1 = nil, player2 = nil)
    @guesser = player1 || HumanPlayer.new
    @picker  = player2 || ComputerPlayer.new
    nil
  end

  def start
    @guesses_made = 0
    initialize_players
    play
  end

  private
    def initialize_players
      secret_length = @picker.tell_secret_length
      @guesser.receive_secret_length(secret_length)
      @known_letters = Array.new(secret_length, nil)
    end

    def play
      cheated = false
      until won?
        display
        current_guess = @guesser.guess(@known_letters.dup)
        if current_guess.nil?
          cheated = true
          break
        end
        positions = @picker.handle_guess_response(current_guess, @known_letters.dup)
        positions.each {|pos| @known_letters[pos] = current_guess}
        @guesses_made += 1
      end
      display
      puts cheated ? "Sorry, picker cheated!" : "You win! It only took #{@guesses_made} guesses!"

    end


    def display
      puts "It's a #{known_letters.length} letter word"
      puts @known_letters.map{|letter| letter || "_"}.join(" ")
      puts (1..known_letters.length).to_a.join(" ")
    end

    def won?
      @known_letters.none? { |x| x.nil? }
    end
end

class HumanPlayer
  attr_reader :secret_length

  def initialize
  end

  def receive_secret_length(secret_length)
    @secret_length = secret_length
  end

  # picker methods
  def pick_secret_word
  end

  def tell_secret_length
    print "What is your word's length?"
      @secret_length = valid_length?(gets.chomp)
  rescue ArgumentError => e
    puts e.message
    retry
  end


  def valid_length?(input)
    length = Integer(input)
    if input.empty?
      raise ArgumentError.new "Cannot be empty!"

    elsif length > 20
      raise ArgumentError.new "Can't have such a big word!"
    end
  end

  def handle_guess_response(guess, known_letters)
    loop do
      puts "Player guessed #{guess}"
      print "Index of guess location? (press return if wrong letter)  "
      inputted_positions = clean_positions(gets.chomp)
      if valid_positions?(inputted_positions, known_letters)
        return inputted_positions
      end
      puts "Invalid space"
    end
  end

  def valid_positions?(positions, known_letters)
    positions.all? { |pos| pos.between?(0,@secret_length-1) && known_letters[pos].nil? } #issue with secret length
  end

  def clean_positions(positions)
    positions.split(" ").map{|position| position.to_i - 1}
  end

  def guess(known_letters) #this method does not use known letters
    print "Guess a letter: "

    valid_guess?(gets.chomp)
  rescue ArgumentError => e
    puts "Did not receive a valid guess"
    puts "Error was: #{e.message}"

    retry
  end


  private

    def valid_guess?(inputted_guess)
      if (inputted_guess.length != 1)
        raise ArgumentError.new "Guesses may only be one letter!"

      elsif !(/[a-zA-Z]/ =~ inputted_guess)
        raise ArgumentError.new "Guess must be a valid letter!"
      end
    end

end


class ComputerPlayer
  attr_accessor :secret_word
  attr_reader :dictionary, :secret_length

  def initialize(filename = "dictionary.txt")
    @filename = filename
    @dictionary = File.readlines(@filename).map(&:chomp).map(&:upcase)
    nil
  end

  def receive_secret_length(secret_length)
    @dictionary = File.readlines(@filename).map(&:chomp).map(&:upcase)
    @secret_length = secret_length
    slim_dictionary_by_length
    @unused_letters = ("A".."Z").to_a
    nil
  end

  def tell_secret_length
    @secret_word = pick_secret_word.upcase
    @secret_word.length
  end

  # picker methods
  def pick_secret_word
    dictionary.sample
  end

  def handle_guess_response(guess_letter, current_positions)
    correct_positions = []
    @secret_word.length.times do |i|
      correct_positions << i if guess_letter == @secret_word[i]
    end
    correct_positions
  end

  #guesser methods
  def guess(known_letters)
    slim_dictionary_by_position(known_letters)
    guess = analyze_dictionary
    @unused_letters.delete_at(@unused_letters.index(guess.upcase))
    guess
  end

  def slim_dictionary_by_length
    @dictionary.select! {|word| word.length == @secret_length}
  end

  def slim_dictionary_by_position(known_letters)
    @dictionary.select! { |word| possible_word(word, known_letters) }
  end

  def possible_word(word, known_letters)
    known_letters.each_with_index do |letter, index|
      next if letter.nil?
      return false if letter != word[index]
    end
    true
  end

  def analyze_dictionary
    all_letters = []
    best_guess = nil
    max_count = 0
    @dictionary.each {|word| all_letters += word.upcase.split("")}
    @unused_letters.each do |letter|
      letter_count = all_letters.count(letter)
      if letter_count > max_count
        best_guess = letter
        max_count = letter_count
      end
    end
    best_guess
  end
  # def guess(known_letters)
  #   @unused_letters.shuffle!.pop
  #
  # end
end
