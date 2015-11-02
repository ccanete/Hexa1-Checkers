/****************************************
			IA level 1
****************************************/

/**
* Returns a random position among the possibles moves
* +Player : player color
* -X : X coordinate for the chosen pawn randomly
* -Y : Y coordinate for the chosen pawn randomly
* -Xdest : X coordinate for the move chosen randomly
* -Ydest : Y coordinate for the move chosen randomly
*/
iaMove(level1, Player, X, Y, Xdest, Ydest):-
	getPossibleMoves(Player, PossibleMoves),
	findBestPlay([X,Y,Xdest,Ydest], PossibleMoves).

/**
* Return the smartest move to do for the AI
*/
findBestPlay([X,Y,Xdest,Ydest], PossibleMoves):-
	predsort(compareLeveUno, PossibleMoves, SortedMoves), % Sorts a list automatically using predicate compareLeveUno
	last(SortedMoves, [X,Y,Xdest,Ydest]). % Get the max
/**
* Compares two scrores
* -Delta : equals > or < or =
*/
compareLeveUno(Delta, [X1,Y1,Xdest1,Ydest1], [X2,Y2,Xdest2,Ydest2]):-
	write('Compare'),
	worthToPlay(X1,Y1,Xdest1,Ydest1,R1),
	worthToPlay(X2,Y2,Xdest2,Ydest2,R2),
	write(R1), write(R2),
	compare(Delta, R1, R2).
