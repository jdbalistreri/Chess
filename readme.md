# Command Line Chess

##Features

###Full Chess Functionality
- Implements full suite of chess moves, including en passant, castling, and pawn promotion
- Enforces valid moves (i.e. cannot result in check for own king)
- Can be configured to use any combination of human and computer players
- Default computer AI makes random moves for demonstration purposes

###Friendly UI
- Navigates with arrow keys, not chess notation
- Highlights available moves for a selected piece
- Tracks and displays captured pieces

![gameplay]

##Implementation

###Object Oriented Implementation
- [Sliding piece][sliding-piece] and [stepping piece][stepping-piece] modules mixed-in to DRY up shared methods
- Individual pieces classes (e.g. [Queen][queen]) inherit from [Piece][piece] superclass

###Move Validation
- Creates a deep dup of the [board][board] and tests validity of moves, for both feasibility and whether or not a move leaves a player's king in check

###Outside Gems
- [Colorize][colorize] gem adds color to rendered string output
- [Dispel][dispel] gem captures keystrokes and re-renders board with updated state


##How to run
###Download/install

###Run

[gameplay]: ./images/gameplay.png
[sliding-piece]: ./chess/pieces/sliding_piece.rb
[stepping-piece]: ./chess/pieces/stepping_piece.rb
[queen]: ./chess/pieces/queen.rb
[piece]: ./chess/pieces/piece.rb
[board]: ./chess/board.rb
[colorize]: https://github.com/fazibear/colorize
[dispel]: https://github.com/grosser/dispel
