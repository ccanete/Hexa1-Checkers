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
