%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Checkers game             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dynamic board/1.
board([wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
               nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
               wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
               nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
               em,nl,em,nl,em,nl,em,nl,em,nl,
               nl,em,nl,em,nl,em,nl,em,nl,em,
               bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
               nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,
               bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
               nl,bp,nl,bp,nl,bp,nl,bp,nl,bp]).

/* Module Imports */
:-['actions/queen.pl'].
:-['helpers/drawBoard.pl'].
:-['actions/action.pl'].
:-['actions/checkEat.pl'].

% Main function
initGame:-
  initBoard(Board),
  %% test eat and move
  write('--- GAME 1 ---'),nl,
  printBoard(Board),
  play(Board, 4, 2, 2, 4, white),
  write('--- GAME 2 ---'),nl,
  printBoard(Board),
  play(Board, 1, 1, 2, 10, white).
  %write('--- Dynamic board test ---'),
  %board(X),
  %printBoard(X).

% Piece : the piece you're looking for
%play(Board, X, Y, NewX, NewY, Color):- gameover, !.
play(Board, X, Y, NewX, NewY, Color):-
  checkMove(Board, X, Y, NewX, NewY, Color),
  processMove(Board, X, Y, NewX, NewY, BoardAfterMove),
  printBoard(BoardAfterMove),
  % BE CAREFULL, IF NO EAT WHAT BOARD SHOULD BE USED ?
  %checkEat(Board, X, Y, NewX, NewY),
  processEat(BoardAfterMove, X, Y, NewX, NewY, BoardAfterEat),
  printBoard(BoardAfterEat),
  doQueen(BoardAfterEat, BoardAfterQueen, NewX, NewY),
  printBoard(BoardAfterQueen),
  continuePlaying(BoardAfterQueen),
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
checkMove(Board, X, Y, NewX, NewY, white):-
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  Piece == em,
  OldX is X+1,
  OldY is Y+1,
  write('X : '),
  write(OldX),nl,
  write('Y : '),
  write(OldY),nl,
  NewX == OldX,
  NewY == OldY.

checkMove(Board, X, Y, NewX, NewY, white):-
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  Piece == em,
  OldX is X+1,
  OldY is Y-1,
  write('X : '),
  write(OldX),nl,
  write('Y : '),
  write(OldY),nl,
  NewX == OldX,
  NewY == OldY.

checkMove(Board, X, Y, NewX, NewY, black):-
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  Piece == em,
  OldX is X-1,
  OldY is Y-1,
  write('X : '),
  write(OldX),nl,
  write('Y : '),
  write(OldY),nl,
  NewX == OldX,
  NewY == OldY.

checkMove(Board, X, Y, NewX, NewY, black):-
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  Piece == em,
  OldX is X-1,
  OldY is Y+1,
  write('X : '),
  write(OldX),nl,
  write('Y : '),
  write(OldY),nl,
  NewX == OldX,
  NewY == OldY.


% Check if a player has won
continuePlaying(Board):-
  continuePlaying(Board, white),
  continuePlaying(Board, black).
continuePlaying(Board, white):-
  member(wp, Board),!;member(wq, Board),!.
continuePlaying(Board, black):-
  member(bp, Board),!;member(bq, Board),!.


% Return the piece at X, Y coordinate in the Board
getPiece(Board, X, Y, Piece) :-
  convertCoordinate(X, Y, Pos),
  nth0(Pos, Board, Piece).

%% === Helpers === %%

% Replace an element in an array. (Board, Index, NexElement, NewBoard)
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

/*
% Convert coordinate to array index (index starts at 1)
convertCoordinate(Line, Column, Pos):-
  %write('Line : '),
  %write(Line), nl,
  %write('Column : '),
  %write(Column), nl,
  Line =< 10,
  Line >= 1,
  Column >= 1,
  Column =< 10,
  Pos is (Line-1) * 10 + Column-1.
*/

% Convert coordinate to array index (index starts at 1)
convertCoordinate(Line, Column, Pos):-
  checkBoarders(Line, Column),
  Pos is ((Line-1) * 10 + Column-1).

checkBoarders(Line, Column) :-
  between(1, 10,Line),
  between(1, 10, Column).

% Convert pice code to graphic symbol
pieceToSymbol(nl, '  ').
pieceToSymbol(em, '  ').
pieceToSymbol(bq, 'B ').
pieceToSymbol(wq, 'W ').
pieceToSymbol(bp, 'b ').
pieceToSymbol(wp, 'w ').
pieceToSymbol(Piece, '# ').

%% === End of the Game === %%
%% TODO
% End of game
  % No more white
  % No more black
  % No more possible move
 %end(Board) :-

 %noMore(Board, Color) :-
  % Regarder dans le cours comment parcourir une liste
