%% === Print functions === %%

% Start printing the board recursivly (loop style)
printBoard :-
  write('+--------------------------------+'),nl,
  write('|  |1 |2 |3 |4 |5 |6 |7 |8 |9 |10|'), nl,
  write('|--+--+--+--+--+--+--+--+--+--+--|'), nl,
  printBoard(1), !.
% Calls the PrintLine function and iterates
printBoard(Y) :-
  printLine(Y),
  printGrid,
  NextLine is Y + 1,
  printBoard(NextLine).
% End of the loop
printBoard(11) :-
  nl,!.

% Print a seperation line
printGrid :-
  write('|--+--+--+--+--+--+--+--+--+--+--|'), nl.

% Start printing a line recursivly (loop style)
printLine(Y) :-
   write('|'),
   printLine(Y, 0).
% Print a piece of the line then recursiv call
printLine(Y, 0) :-
  write(Y),
  write(' |'),
  printLine(Y, 1).
printLine(Y, X) :-
  getPiece(X, Y, Piece),
  pieceToSymbol(Piece, Symbol),
  write(Symbol),
  write('|'),
  NextCol is X + 1,
  printLine(Y, NextCol).
% End of the loop
printLine( _, 11) :- nl,!.

% Convert pice code to graphic symbol
pieceToSymbol(nl, '  ').
pieceToSymbol(em, '  ').
pieceToSymbol(bq, 'B ').
pieceToSymbol(wq, 'W ').
pieceToSymbol(bp, 'b ').
pieceToSymbol(wp, 'w ').
pieceToSymbol(Piece, Piece).
