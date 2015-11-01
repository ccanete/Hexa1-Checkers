/********************************
			RANDOM IA
*******************************/

/**
* Returns a random position among the possibles moves
* +Player : player color
* -X : X coordinate for the chosen pawn randomly
* -Y : Y coordinate for the chosen pawn randomly
* -Xdest : X coordinate for the move chosen randomly
* -Ydest : Y coordinate for the move chosen randomly
*/
randomIA(Player, X, Y, Xdest, Ydest):-
	getPossibleMoves(Player, PossibleMoves),
	random_member([X,Y,Xdest,Ydest], PossibleMoves).

playIA(Player, randomIa):-
  continuePlaying,
  nl, write('Player '), write(randomIa), write(' plays.'),nl,
  randomIA(Player,X,Y,NewX,NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Player, X, Y, NewX, NewY),
  zombieToEmpty,
  nl, printBoard,
  nextPlayer(Player, NextPlayer),
  play(NextPlayer, human).
  %TODO: handle a wrong turn
