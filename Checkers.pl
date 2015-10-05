%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prolog game                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main function
% Piece : the piece you're looking for
play(Piece, X, Y):-
  initBoard(Board),
  findPiece(Board, X, Y, Piece).
  % movePiece(Board, 1, 2, 1, 3, NewBoard).

% Get the initial board, return Board
initBoard(Board) :-
  Board = [n,x,n,x,n,x,n,x,x,n,x,n,x,n,x,n,n,x,n,x,n,x,n,x,e,n,e,n,e,n,e,n,n,e,n,e,n,e,n,e,o,n,o,n,o,n,o,n,n,o,n,o,n,o,n,o,o,n,o,n,o,n,o,n].

% Not functionnal
movePiece(Board, X, Y, NewX, NewY, NewBoard) :-
  convertCoordinate(X, Y, Pos),
  nth1(Pos, Board, Elem).

% Return the piece at X, Y coordinate in the Board
findPiece(Board, X, Y, Piece) :-
  convertCoordinate(X, Y, Pos),
  nth1(Pos, Board, Piece).

% Convert coordinate to array index (index starts at 1)
convertCoordinate(Line, Column, Pos):-
  Pos is (Line-1) * 10 + Column.
