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
  nl, write('Player '), write(Player), write(' plays.'),nl,
  userMove(X,Y,NewX,NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Player, X, Y, NewX, NewY),
  nl, printBoard,
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
  doEat(X, Y, NewX, NewY),
  doQueen(NewX, NewY).
