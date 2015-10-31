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

playCheckers:-
  initBoard,
  printBoard,
  play(white).

play(Player):-
  continuePlaying,
  write('Player '), write(Player), write(' plays.'),nl,
  getUserMove(X,Y,NewX,NewY),
  write('Move: X='), write(X), write(', Y='), write(Y), write(', NewX='), write(NewX), write(', NewY='), write(NewY),nl,
  processTurn(Player, X, Y, NewX, NewY),
  nextPlayer(Player, NextPlayer),
  play(NextPlayer).
  %TODO: handle a wrong turn
play(Player):-
  %GameOver for a player
  not(continuePlaying),
  %TODO: Find who has won
  write('GameOver').

%play(Board, X, Y, NewX, NewY, Color):- gameover, !.
processTurn(Player, X, Y, NewX, NewY):-
  doMove(X, Y, NewX, NewY),
  printBoard,
  doEat(X, Y, NewX, NewY),
  printBoard,
  doQueen(NewX, NewY),
  printBoard.
