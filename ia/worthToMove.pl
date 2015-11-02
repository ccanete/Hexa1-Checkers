
% Worth to eat basic case: after eating once, 
% we dont want to be eaten

% R is set to 1 if we can eat one piece, 
% or 0 if the same piece can be eaten afterwards

% TODO : include the predicate canMove 
% and worthToMove along with the upper rule

/**
* Evaluate the score R for a possible move
* -R : score
*/
% EAT
worthToPlay(X, Y, NewX, NewY, R):- 
	checkEat(X, Y, NewX, NewY),
	write('Eat'),
	% worthToEat(X, Y, NewX, NewY, R),
	R is 2.
% MOVE
worthToPlay(X, Y, NewX, NewY, R):- 
	checkMove(X, Y, NewX, NewY),
	write('Move'),
	worthToMove(X, Y, NewX, NewY, R).
% FAIL
worthToPlay(X, Y, NewX, NewY, R):- 
	write('Null'),
	R is -1.

worthToMove(X, Y, NewX, NewY, R):- 
	% R - 1 if eaten so that it wont go unless it has to
	getPiece(X, Y, Piece),
	% simulateMove(X,Y,NewX,NewY),
	% processMove()
	mightBeEaten(NewX, NewY, Piece, R).

	% R + 1 if our piece can eat afterwards
	%getPiece(X, Y)
	%canEat(NewX, NewY, R).



/**
* (WIGHT) Returns 1 if cant be eaten or 0 if can be eaten after moving
* -R : score
*/
mightBeEaten(NewX, NewY, (wp;wq), R):-
	getPiece(NewX-1, NewY+1, PieceFront1),
	getPiece(NewX+1, NewY+1, PieceFront2),
	getPiece(NewX+1, NewY-1, PieceBack1),
	getPiece(NewX-1, NewY-1, PieceBack2),

	% check cant be eaten 
	mightBeEaten(R, PieceFront1, PieceFront2, PieceBack1, PieceBack2).

mightBeEaten(1, em, em, _, _).
% Case PieceFront1 is a bp
mightBeEaten(0, bp, _, em, _).
mightBeEaten(1, bp, _, not(em), _).
% Case PieceFront2 is a bp
mightBeEaten(0, _, bp, _, em).
mightBeEaten(1, _, bp, _, not(em)).
mightBeEaten(-1, _, _, _, _).


/**
* (BLACK) Returns 1 if cant be eaten or 0 if can be eaten after moving
* -R : score
*/
mightBeEaten(NewX, NewY, (bp;bq), R):-
	getPiece(NewX-1, NewY-1, PieceFront1),
	getPiece(NewX+1, NewY-1, PieceFront2),
	getPiece(NewX+1, NewY+1, PieceBack1),
	getPiece(NewX-1, NewY+1, PieceBack2),
	% check cant be eaten 
	mightBeEaten(R, PieceFront1, PieceFront2, PieceBack1, PieceBack2).

mightBeEaten(1, em, em, _, _).
% Case PieceFront1 is a bp
mightBeEaten(0, wp, _, em, _).
mightBeEaten(1, wp, _, not(em), _).
% Case PieceFront2 is a bp
mightBeEaten(0, _, wp, _, em).
mightBeEaten(1, _, wp, _, not(em)).
mightBeEaten(-1, _, _, _, _).

mightBeEaten(_, _, _, -1).
