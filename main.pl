%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Checkers game             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* Module Imports */
?- ['actions/queen.pl'].
?- ['actions/eat.pl'].
?- ['actions/move.pl'].
?- ['helpers/drawBoard.pl'].
?- ['helpers/rules.pl'].
?- ['helpers/turn.pl'].
?- ['helpers/util.pl'].
?- ['ia/helpersIA.pl'].
?- ['ia/randomIA.pl'].
?- ['ia/IALevelUno.pl'].
?- ['ia/minimaxIA.pl'].
%?- ['ia/worthToMove.pl'].

?- set_prolog_stack(global, limit(1*10**9)). % 1GB max global stack size
?- set_prolog_stack(local, limit(1*10**9)). % 1GB max local stack size

%% Set IA %%
setIA(0) :-
    b_setval(iaChoice, randomIA).
setIA(1) :-
    b_setval(iaChoice, level1).
setIA(2) :-
    b_setval(iaChoice, minmax).

playCheckers:-
  getIALevel(Level),
  setIA(Level),
  setState(board),
  initBoard,
  printBoard,
  play(white, alphabeta).

play(Player, human):-
  continuePlaying,
  nl, write('Player '), write(Player), write(' plays the .'),write(Player),nl,
  userMove(X,Y,NewX,NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Player, X, Y, NewX, NewY),
  nl, printBoard,
  nextPlayer(Player, NextPlayer),
  play(NextPlayer, minmax).

play(Player, alphabeta):-
  %b_getval(iaChoice, IAChoice),
  continuePlaying,
  nl, write('Player '), write("alphabeta"), write(' plays.'),nl,
  iaMove(minmax, Player, X, Y, NewX, NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Player, X, Y, NewX, NewY),
  nl, printBoard,
  nextPlayer(Player, NextPlayer),
  play(NextPlayer, randomIA).

play(Player, minmax):-
  %b_getval(iaChoice, IAChoice),
  continuePlaying,
  nl, write('Player '), write("alphabeta"), write(' plays the .'), write(Player), nl,
  iaMove(alphabeta, Player, X, Y, NewX, NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Player, X, Y, NewX, NewY),
  nl, printBoard,
  nextPlayer(Player, NextPlayer),
  play(NextPlayer, randomIA).

play(Player, randomIA):-
  b_getval(iaChoice, IAChoice),
  continuePlaying,
  nl, write('Player '), write("randomIA"), write(' plays.'),nl,
  iaMove(randomIA, Player, X, Y, NewX, NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Player, X, Y, NewX, NewY),
  nl, printBoard,
  nextPlayer(Player, NextPlayer),
  play(NextPlayer, alphabeta).

play(Player, _):-
  %GameOver for a player
  not(continuePlaying),
  %getWinner(Winner),
  write('GameOver'),nl.
  %write(Winner), write(" wins! Congratulations!").
