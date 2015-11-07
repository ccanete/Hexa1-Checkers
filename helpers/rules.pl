/**************************
		RULES
**************************/

/**
* Checks if the player is moving one of its pieces
* Player : player color
* X : X coordinate for the current piece we want to move
* Y : Y coordinate for the current piece we want to move
*/
allowedPlay(Player, X, Y):-
	getPiece(X, Y, Piece),
	allowedPlay(Player, Piece).

allowedPlay(black, bp).
allowedPlay(black, bq).
allowedPlay(white, wp).
allowedPlay(white, wq).

/**
* Unify all the checks we verify before processing a play
* Player : player color
* X : X coordinate for the current piece we want to move
* Y : Y coordinate for the current piece we want to move
* NewX : X destination coordinate
* NewY : Y destination coordinate
*/
checkPlay(Player, X, Y, NewX, NewY):-
	allowedPlay(Player, X, Y),
	(checkEat(X, Y, _, _, NewX, NewY);checkMove(X, Y, NewX, NewY)).
