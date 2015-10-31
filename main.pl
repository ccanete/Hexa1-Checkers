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
?- ['helpers/turn.pl'].

% Main function
playCheckers:-
  initBoard(Board),
  printBoard(Board),
  play(Board, white).

play(Board, Player):-
  continuePlaying(Board),
  write('Player '), write(Player), write(' plays.'),nl,
  getUserMove(X,Y,NewX,NewY),
  write('Move: X='), write(X), write(', Y='), write(Y), write(', NewX='), write(NewX), write(', NewY='), write(NewY),nl,
  processTurn(Board, Player, X, Y, NewX, NewY, NewBoard),
  nextPlayer(Player, NextPlayer),
  play(NewBoard, NextPlayer).
  %TODO: handle a wrong turn

play(Board, Player):-
  %GameOver for a player
  not(continuePlaying(Board)),
  %TODO: Find who has won
  write('GameOver').

%play(Board, X, Y, NewX, NewY, Color):- gameover, !.
processTurn(Board, Player, X, Y, NewX, NewY, BoardAfterQueen):-
  doMove(Board, X, Y, NewX, NewY, BoardAfterMove),
  printBoard(BoardAfterMove),
  doEat(BoardAfterMove, X, Y, NewX, NewY, BoardAfterEat),
  printBoard(BoardAfterEat),
  doQueen(BoardAfterEat, BoardAfterQueen, NewX, NewY),
  printBoard(BoardAfterQueen).
