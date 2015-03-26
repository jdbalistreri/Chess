# Command Line Chess

##Features

###Friendly UI
- Navigates with arrow keys, not chess notation
- Highlights available moves for a selected piece
- Tracks and displays captured pieces


##Implementation

###Object Oriented Implementation
- Sliding piece and stepping piece modules mixed-in to DRY up shared methods
- Individual pieces classes (e.g. Queen) inherit from Piece superclass

###Move Validation
- Creates a deep dup of the board and tests validity of moves, for both feasibility and whether or not a move leaves a player's king in check

###Outside Gems
- Colorize gem adds color to rendered string output
- Dispel gem captures keystrokes and re-renders board with updated state
