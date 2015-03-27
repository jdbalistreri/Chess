# Command Line Chess

##Features

###Full Chess Functionality
- Implements full suite of chess moves, including en passant, castling, and pawn promotion
- Enforces valid moves (i.e. cannot result in check)
- Can be configured to use any combination of human and computer players
- Computer AI makes random moves for demonstration purposes

###Friendly UI
- Navigates with arrow keys, not chess notation
- Highlights available moves for a selected piece
- Tracks and displays captured pieces

##Implementation

###Object Oriented Implementation
- Sliding piece (link) and stepping piece (link) modules mixed-in to DRY up shared methods
- Individual pieces classes (e.g. Queen(link)) inherit from Piece superclass (link)

###Move Validation
- Creates a deep dup of the board and tests validity of moves, for both feasibility and whether or not a move leaves a player's king in check

###Outside Gems
- Colorize gem adds color to rendered string output
- Dispel gem captures keystrokes and re-renders board with updated state
