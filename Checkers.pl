%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prolog game                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main function
% Piece : the piece you're looking for
play(Board, X, Y, NewX, NewY, Color):-
  initBoard(Board),
  % Get the piece to move
  findPiece(Board, X, Y, PieceToMove),
  % Get the piece at the destination place
  findPiece(Board, NewX, NewY, DestPiece),
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%% Constraints on PieceToMove, DestPiece and Color %%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %PieceLastPlace is e,
  %PieceNewPlace is Color,
  printBoard(Board).
  %movePiece(Board, X, Y, NewX, NewY, PieceLastPlace, PieceNewPlace, NewBoard).

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
  Line >= 1,
  Column >= 1,
  Column =< 10,
  Pos is (Line-1) * 10 + Column-1.

% TODO: Reccursiv printBoard
% TODO: Convert id (wp, bp, etc) to graphic element X, O etc
printBoard(Board) :-
  write('+----------------------------+'),nl,
  printBoard(Board, 1).

printBoard(Board, Line) :-
  printLine(Board, Line),
  printGrid,
  NextLine is Line + 1,
  printBoard(Board, NextLine).

printBoard( _, 11) :-
  write('+----------------------------+'),nl,!.

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

% End of game
	% No more white
	% No more black
	% No more possible move
 %end(Board) :-

 %noMore(Board, Color) :-
	% Regarder dans le cours comment parcourir une liste
