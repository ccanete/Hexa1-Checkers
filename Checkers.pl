%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prolog game                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main function
% Piece : the piece you're looking for
play(Piece):-
  initBoard(Board),
  %findPiece(Board, X, Y, Piece),
  printBoard(Board).
  % movePiece(Board, 1, 2, 1, 3, NewBoard).

% The initial board (origin box : lower left corner of the board)
initBoard(Board) :-
      Board = [wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
				nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
				wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
				nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
				em,nl,em,nl,em,nl,em,nl,em,nl,
				nl,em,nl,em,nl,em,nl,em,nl,em,
				bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
				nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,
				bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
				nl,bp,nl,bp,nl,bp,nl,bp,nl,bp].

% nl : null (unaccessible box)
% em : free box
% bq : black queen
% wq : white queen
% bp : black pawn
% wp : white pawn

% Not functionnal
movePiece(Board, X, Y, NewX, NewY, NewBoard) :-
  convertCoordinate(X, Y, Pos),
  nth0(Pos, Board, Elem).

% Return the piece at X, Y coordinate in the Board
findPiece(Board, X, Y, Piece) :-
  convertCoordinate(X, Y, Pos),
  nth0(Pos, Board, Piece).

% Convert coordinate to array index (index starts at 1)
convertCoordinate(Line, Column, Pos):-
  Pos is ((Line-1) * 10 + (Column-1)).

% TODO: Reccursiv printBoard
% TODO: Convert id (wp, bp, etc) to graphic element X, O etc
printBoard(Board) :-
  write('+----------------------------+'),nl,
  printLine(Board, 1),
  printGrid,
  printLine(Board, 2),
  printGrid,
  printLine(Board, 3),
  printGrid,
  printLine(Board, 4),
  printGrid,
  printLine(Board, 5),
  printGrid,
  printLine(Board, 6),
  printGrid,
  printLine(Board, 7),
  printGrid,
  printLine(Board, 8),
  printGrid,
  printLine(Board, 9),
  printGrid,
  printLine(Board, 10),
  write('+----------------------------+'),nl.


printGrid :-
  write('|--+--+--+--+--+--+--+--+--+--|'), nl.

printLine(Board, Line) :-
   write('|'),
   printLine(Board, Line, 1).

printLine( _, _, 11) :- nl,!.

printLine(Board, Line, Col) :-
  findPiece(Board, Line, Col, Piece),
  write(Piece),
  write('|'),
  NextCol is Col + 1,
  printLine(Board, Line, NextCol).
