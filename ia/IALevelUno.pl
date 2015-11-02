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
levelUnoAI(Player, X, Y, Xdest, Ydest):-
	nl, write('Level UNO IA is playing'),
	getPossibleMoves(Player, PossibleMoves),
	findBestPlay([X,Y,Xdest,Ydest], PossibleMoves).

/**
* Return the smartest move to do for the AI
*/
findBestPlay([X,Y,Xdest,Ydest], PossibleMoves):-
	predsort(compareLeveUno, PossibleMoves, SortedMoves), % Sorts a list automatically using predicate compareLeveUno
	nth0(0, SortedMoves, [X,Y,Xdest,Ydest]). % Get the first element from the SortedMoves list

/**
* Compares two scrores
* -Delta : equals > or < or =
*/
compareLeveUno(Delta, [X1,Y1,Xdest1,Ydest1], [X2,Y2,Xdest2,Ydest2]):-
	worthToMove(X1,Y1,Xdest1,Ydest1,R1),
	worthToMove(X2,Y2,Xdest2,Ydest2,R2),
	compare(Delta, R1, R2).
