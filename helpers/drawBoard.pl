%% === Print functions === %%

% Start printing the board recursivly (loop style)
printBoard(Board) :-
  write('+--------------------------------+'),nl,
  write('|  |1 |2 |3 |4 |5 |6 |7 |8 |9 |10|'), nl,
  write('|--+--+--+--+--+--+--+--+--+--+--|'), nl,
  printBoard(Board, 1), !.
% Calls the PrintLine function and iterates
printBoard(Board, Y) :-
  printLine(Board, Y),
  printGrid,
  NextLine is Y + 1,
  printBoard(Board, NextLine).
% End of the loop
printBoard( _, 11) :-
  nl,!.

% Print a seperation line
printGrid :-
  write('|--+--+--+--+--+--+--+--+--+--+--|'), nl.

% Start printing a line recursivly (loop style)
printLine(Board, Y) :-
   write('|'),
   printLine(Board, Y, 0).
% Print a piece of the line then recursiv call
printLine(Board, Y, 0) :-
  write(Y),
  write(' |'),
  printLine(Board, Y, 1).
printLine(Board, Y, X) :-
  getPiece(Board, X, Y, Piece),
  pieceToSymbol(Piece, Symbol),
  write(Symbol),
  write('|'),
  NextCol is X + 1,
  printLine(Board, Y, NextCol).
% End of the loop
printLine( _, _, 11) :- nl,!.

% Convert pice code to graphic symbol
pieceToSymbol(nl, '  ').
pieceToSymbol(em, '  ').
pieceToSymbol(bq, 'B ').
pieceToSymbol(wq, 'W ').
pieceToSymbol(bp, 'b ').
pieceToSymbol(wp, 'w ').
pieceToSymbol(Piece, Piece).
