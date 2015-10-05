%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prolog game                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main function
% Piece : the piece you are looking for
play(Piece, X, Y):-
  initBoard(Board),
  findPiece(Board, X, Y, Piece).
  % movePiece(Board, 1, 2, 1, 3, NewBoard).

% The initial board (origin box : lower left corner of the board)
init( Board) :-
      Board = b(wp,n,wp,n,wp,n,wp,n,wp,n,
				n,wp,n,wp,n,wp,n,wp,n,wp,
				wp,n,wp,n,wp,n,wp,n,wp,n,
				n,wp,n,wp,n,wp,n,wp,n,wp,
				e,n,e,n,e,n,e,n,e,n,
				n,e,n,e,n,e,n,e,n,e,
				bp,n,bp,n,bp,n,bp,n,bp,n,
				n,bp,n,bp,n,bp,n,bp,n,bp,
				bp,n,bp,n,bp,n,bp,n,bp,n,
				n,bp,n,bp,n,bp,n,bp,n,bp).

% n : null (unaccessible box)
% e : free box
% bq : black queen
% wq : white queen
% bp : black pawn
% wp : white pawn


% Update the list with new position
move(Board, OldX, OldY, NewX, NewY, NewL) :- 
	findPiece(Board, OldX, OldY, OldPiece),
	findPiece(Board, NewX, NewY, NewPiece),
	OldPiece = not(e),



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
  Line =< 10,
  Line => 1,
  Column => 1,
  Column =< 10,
  Pos is (Line-1) * 10 + Column.

