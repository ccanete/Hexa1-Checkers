%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Checkers game             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/* Module Imports */
?- ['actions/queen.pl'].
?- ['actions/eat.pl'].
?- ['actions/move.pl'].
?- ['actions/checkEat.pl'].
?- ['helpers/drawBoard.pl'].
?- ['helpers/util.pl'].

% Main function
initGame:-
  initBoard,
  printBoard,
  %% test eat and move
  write('--- GAME 1 ---'),nl,
  play(4, 4, 5, 5, white).

%play(X, Y, NewX, NewY, Player):- gameover, !.
play(X, Y, NewX, NewY, Player):-
  doMove(X, Y, NewX, NewY),

  %b_getval(board, Board),

  % BE CAREFULL, IF NO EAT WHAT BOARD SHOULD BE USED ?
  %checkEat(Board, X, Y, NewX, NewY),
  %processEat(BoardAfterMove, X, Y, NewX, NewY, BoardAfterEat),
  %printBoard(BoardAfterEat),
  %doQueen(BoardAfterEat, BoardAfterQueen, NewX, NewY),
  %printBoard(BoardAfterQueen),
  %continuePlaying(BoardAfterQueen),

  %b_setval(board, BoardAfterMove),

  printBoard.

% The initial board (origin box : lower left corner of the board)
initBoard :-
      b_setval(board, [wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
      				 nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
      				 wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
      				 nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
      				 em,nl,em,nl,em,nl,em,nl,em,nl,
      				 nl,em,nl,em,nl,em,nl,em,nl,em,
      				 bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
      				 nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,
      				 bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
      				 nl,bp,nl,bp,nl,bp,nl,bp,nl,bp]).

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
