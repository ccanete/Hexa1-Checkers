/**********************************
			MINIMAX AI
***********************************/

/**
* iamove/6
* Returns the best move for minmax AI
* +Player : color player for the ai
* +X, +Y : piece
* -Xdest, -Ydest : best move found
*/
iaMove(minmax, Player, X, Y, Xdest, Ydest):-
	getPossibleMoves(Player, PossibleMoves),
	findMinMax([X,Y,Xdest,Ydest], PossibleMoves).

/**
* findBestPlayMinMax/2
* Finds the minMax incremently
*/
findBestPlayMinMax(Player, [X,Y,Xdest,Ydest], PossibleMoves, Score, Depth, Heuristic) :-
	.


/**
* count/2
* counts the number Piece are on the board
*
*/
count(Piece, Res) :-
    b_getval(board,List),
    countL(List, Piece, Res, 0).

countL( [], _, Res, Res) :- !. % for the end of List

% When Piece is found
countL( [Piece|Xs], Piece, Res, Counter) :-
    !, 
    Counter1 is Counter + 1,
    countL(Xs, Piece, Res, Counter1).

% When Piece is not found
countL( [_|Xs], Piece, Res, Counter) :-
    countL(Xs, Piece, Res, Counter).