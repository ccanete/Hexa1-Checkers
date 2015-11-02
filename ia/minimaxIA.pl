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
minmaxIA(Player, X, Y, Xdest, Ydest):-
	getPossibleMoves(Player, PossibleMoves),
	findMinMax([X,Y,Xdest,Ydest], PossibleMoves).

/**
* findBestPlayMinMax/2
* Finds the minMax incremently
*/
findMinMax(Player, [X,Y,Xdest,Ydest], PossibleMoves, Score, Depth, Heuristic) :-
	.

/**
* evaluateBoard/2
* Calculte a Player's score
* -Score : Player's score for a board
*/
evaluateBoard(white, Score) :-
	count(wp, NBwp),
	count(wq, NBwq),
	count(bp, NBbp),
	count(bq, NBbq),
	Score is 2*NBwq + NBwp - 2*NBbq - NBbp.

evaluateBoard(black, Score) :-
	count(wp, NBwp),
	count(wq, NBwq),
	count(bp, NBbp),
	count(bq, NBbq),
	Score is - 2*NBwq - NBwp + 2*NBbq + NBbp.

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