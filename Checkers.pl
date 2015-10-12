%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prolog game                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main function
initGame:-
  initBoard(Board),
  write('Game'),nl,
  printBoard(Board),
  play(Board, 4, 2, 5, 1, white).

% Piece : the piece you're looking for
play(Board, X, Y, NewX, NewY, Color):-
  %checkMove(Board, X, Y, NewX, NewY),
  processMove(Board, X, Y, NewX, NewY, NewBoard),
  printBoard(NewBoard),
  continuePlaying(NewBoard),
  write('Play again !').

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

% Check if a player has won
continuePlaying(Board):-
  continuePlaying(Board, white),
  continuePlaying(Board, black).
continuePlaying(Board, white):-
  member(wp, Board),!;member(wq, Board),!.
continuePlaying(Board, black):-
  member(bp, Board),!;member(bq, Board),!.

% Not functionnal
processMove(Board, X, Y, NewX, NewY, NewBoard) :-
  convertCoordinate(X, Y, Pos),
  convertCoordinate(NewX, NewY, NewPos),
  nth0(Pos, Board, Piece),
  replace(Board, Pos, em, TempBoard),
  replace(TempBoard, NewPos, Piece, NewBoard).


% Return the piece at X, Y coordinate in the Board
% TODO: Change find to get
findPiece(Board, X, Y, Piece) :-
  convertCoordinate(X, Y, Pos),
  nth0(Pos, Board, Piece).

%% === Helpers === %%

% Replace an element in an array. (Board, Index, NexElement, NewBoard)
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

% Convert coordinate to array index (index starts at 1)
convertCoordinate(Line, Column, Pos):-
  Line =< 10,
  Line >= 1,
  Column >= 1,
  Column =< 10,
  Pos is (Line-1) * 10 + Column-1.

% Convert pice code to graphic symbol
pieceToSymbol(nl, '  ').
pieceToSymbol(em, '  ').
pieceToSymbol(bq, 'B ').
pieceToSymbol(wq, 'W ').
pieceToSymbol(bp, 'b ').
pieceToSymbol(wp, 'w ').
pieceToSymbol(Piece, '# ').

%% === Print functions === %%

% Start printing the board recursivly (loop style)
printBoard(Board) :-
  write('+----------------------------+'),nl,
  printBoard(Board, 1),!.
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
