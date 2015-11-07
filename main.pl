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
?- ['ia/heuristicIA.pl'].

?- set_prolog_stack(global, limit(1*10**9)). % 1GB max global stack size
?- set_prolog_stack(local, limit(1*10**9)). % 1GB max local stack size

playCheckers:-
  getPlayer(Player1, 1),
  setPlayer(player1, Player1),
  getPlayer(Player2, 2),
  setPlayer(player2, Player2),
  setState(board),
  initBoard,
  printBoard,
  b_getval(player1, Player),
  play(white, 1, Player).

play(Color, Number, Player):-
  continuePlaying,
  nl, write('Player '), write(Number), write(" "), write(Player), write(' plays the '), write(Color),nl,
  getPlayerMove(Player, Color, X, Y, NewX, NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Color, X, Y, NewX, NewY),
  nl, printBoard,
  nextPlayer(Color, NextColor),
  nextPlayerTurn(Number, NextNumber, NextPlayer),
  play(NextColor, NextNumber, NextPlayer).

play(_, _, _):-
  %GameOver for a player
  not(continuePlaying),
  getWinner(Winner),
  write(Winner), write(" wins! Congratulations!").
