%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prolog game                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main function
initGame:-
  initBoard(Board),
  printBoard(Board),
  %nl,
  %write('Please choose a piece to move'),nl.
  play(Board, 4, 2, 5, 1, 'white').

% Piece : the piece you're looking for
play(Board, X, Y, NewX, NewY, Color):-
  % Get the piece to move
  findPiece(Board, X, Y, PieceToMove),
  nl, write(PieceToMove), nl,
  % Get the piece at the destination place
  findPiece(Board, NewX, NewY, DestPiece),
  nl, write(DestPiece), nl,
  %processMove(Board, X, Y, newX, newY, newBoard),
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%% Constraints on PieceToMove, DestPiece and Color %%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %PieceLastPlace is e,
  %PieceNewPlace is Color,
  printBoard(newBoard).

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
% TODO: Change find to get
findPiece(Board, X, Y, Piece) :-
  convertCoordinate(X, Y, Pos),
  nth0(Pos, Board, Piece).

%% === Helpers === %%

% Convert coordinate to array index (index starts at 1)
convertCoordinate(Line, Column, Pos):-
  Line =< 10,
  Line >= 1,
  Column >= 1,
  Column =< 10,
  Pos is (Line-1) * 10 + Column-1.

% Convert pice code to graphic symbol
pieceToSymbol('nl', '  ').
pieceToSymbol('em', '  ').
pieceToSymbol('bq', 'B ').
pieceToSymbol('wq', 'W ').
pieceToSymbol('bp', 'b ').
pieceToSymbol('wp', 'w ').
pieceToSymbol(Piece, '# ').

%% === Print functions === %%

% Start printing the board recursivly (loop style)
printBoard(Board) :-
  write('+----------------------------+'),nl,
  printBoard(Board, 1).
% Calls the PrintLine function and iterates
printBoard(Board, Line) :-
  printLine(Board, Line),
  printGrid,
  NextLine is Line + 1,
  printBoard(Board, NextLine).
% End of the loop
printBoard( _, 11) :-
  write('+----------------------------+'),nl,!.

% Print a seperation line
printGrid :-
  write('|--+--+--+--+--+--+--+--+--+--|'), nl.

% Start printing a line recursivly (loop style)
printLine(Board, Line) :-
   write('|'),
   printLine(Board, Line, 1).
% Print a piece of the line then recursiv call
printLine(Board, Line, Col) :-
  findPiece(Board, Line, Col, Piece),
  pieceToSymbol(Piece, Symbol),
  write(Symbol),
  write('|'),
  NextCol is Col + 1,
  printLine(Board, Line, NextCol).
% End of the loop
printLine( _, _, 11) :- nl,!.

%% === End of the Game === %%
%% TODO
% End of game
	% No more white
	% No more black
	% No more possible move
 %end(Board) :-

 %noMore(Board, Color) :-
	% Regarder dans le cours comment parcourir une liste
