%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prolog game                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main function
% Piece : the piece you're looking for
play(Board, Piece, X, Y, NewX, NewY, Color):-
  findPiece(Board, X, Y, PieceToMove),
  findPiece(Board, NewX, NewY, DestPiece),
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%% Constraints on PieceToMove, DestPiece and Color %%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  PieceLastPlace is e,
  PieceNewPlace is Color.
  %movePiece(Board, X, Y, NewX, NewY, PieceLastPlace, PieceNewPlace, NewBoard).

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



% Not functionnal
movePiece(Board, X, Y, NewX, NewY, PieceLastPlace, PieceNewPlace, NewBoard) :-
  convertCoordinate(NewX, NewY, Pos),
  nth0(Pos, Board, Elem).

% Return the piece at X, Y coordinate in the Board
findPiece(Board, X, Y, Piece) :-
  convertCoordinate(X, Y, Pos),
  nth0(Pos, Board, Piece).

% Convert coordinate to array index (index starts at 1)
convertCoordinate(Line, Column, Pos):-
  Line =< 10,
  Line => 1,
  Column => 1,
  Column =< 10,
  Pos is (Line-1) * 10 + Column-1.


% 