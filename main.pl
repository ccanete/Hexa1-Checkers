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
?- ['actions/queen.pl'].
?- ['actions/eat.pl'].
?- ['actions/move.pl'].
?- ['actions/checkEat.pl'].
?- ['helpers/drawBoard.pl'].
?- ['helpers/util.pl'].

% Main function
initGame:-
  initBoard(Board),
  %% test eat and move
  write('--- GAME 1 ---'),nl,
  printBoard(Board),
  play(Board, 4, 4, 5, 5, white).

%play(Board, X, Y, NewX, NewY, Color):- gameover, !.
play(Board, X, Y, NewX, NewY, Color):-
  doMove(Board, X, Y, NewX, NewY, BoardAfterMove),
  printBoard(BoardAfterMove),
  % BE CAREFULL, IF NO EAT WHAT BOARD SHOULD BE USED ?
  %checkEat(Board, X, Y, NewX, NewY),
  %processEat(BoardAfterMove, X, Y, NewX, NewY, BoardAfterEat),
  %printBoard(BoardAfterEat),
  %doQueen(BoardAfterEat, BoardAfterQueen, NewX, NewY),
  %printBoard(BoardAfterQueen),
  %continuePlaying(BoardAfterQueen),
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
