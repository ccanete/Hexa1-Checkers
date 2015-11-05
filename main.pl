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
?- ['ia/alphabetaIA.pl'].
%?- ['ia/worthToMove.pl'].

?- set_prolog_stack(global, limit(1*10**9)). % 1GB max global stack size
?- set_prolog_stack(local, limit(1*10**9)). % 1GB max local stack size

%% Set Players %%
setPlayer(PlayerNumber, 0) :-
    b_setval(PlayerNumber, human).
setPlayer(PlayerNumber, 1) :-
    b_setval(PlayerNumber, randomIA).
setPlayer(PlayerNumber, 2) :-
    b_setval(PlayerNumber, minmax).
setPlayer(PlayerNumber, 3) :-
    b_setval(PlayerNumber, alphabeta).
setPlayer(PlayerNumber, 4) :-
    b_setval(PlayerNumber, heristic).

%% Functions to set the IA level %%
getPlayer(Player, Number):-
  nl,write('Please choose the Player '), write(Number), write(" : "), nl,
	displayPlayers,
	read(Player),
  checkPlayerLevel(Player).
getPlayer(Level):-
  nl,write('Sorry, this Player does not exist.'),nl,
  getPlayer(Level).

checkPlayerLevel(Player):-
	between(0, 4, Player).

displayPlayers:-
	write('Player 0: Human'),nl,
	write('Player 1: Random AI'),nl,
	write('Player 2: Minmax AI'),nl,
	write('Player 3: AlphaBeta AI'),nl.

nextPlayerTurn(1, 2, NextPlayer):-
  b_getval(player2, NextPlayer).
nextPlayerTurn(2, 1, NextPlayer):-
  b_getval(player1, NextPlayer).

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

play(Color, Number, human):-
  continuePlaying,
  nl, write('Player '), write(Number), write(" human"), write(' plays the '), write(Color),nl,
  userMove(X,Y,NewX,NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Color, X, Y, NewX, NewY),
  nl, printBoard,
  nextPlayer(Color, NextColor),
  nextPlayerTurn(Number, NextNumber, NextPlayer),
  play(NextColor, NextNumber, NextPlayer).

play(Color, Number, Player):-
  continuePlaying,
  nl, write('Player '), write(Number), write(" "), write(Player), write(' plays the '), write(Color),nl,
  iaMove(Player, Color, X, Y, NewX, NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Color, X, Y, NewX, NewY),
  nl, printBoard,
  nextPlayer(Color, NextColor),
  nextPlayerTurn(Number, NextNumber, NextPlayer),
  play(NextColor, NextNumber, NextPlayer).

play(_, _, _):-
  %GameOver for a player
  not(continuePlaying),
  %getWinner(Winner),
  write('GameOver'),nl.
  %write(Winner), write(" wins! Congratulations!").
