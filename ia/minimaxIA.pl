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
minmaxIA(Player, BestX, BestY, BestXdest, BestYdest):-
	write("MINMAX IS PLAYING"),nl,
	initSimulationBoard,
	setState(simulation),
	printBoard,
	getPossibleMoves(Player, PossibleMoves),
	write(PossibleMoves),nl,
	findMinMax(Player, [BestX,BestY,BestXdest,BestYdest], PossibleMoves, [], 3),
	setState(board).

/**
* findBestPlayMinMax/5
* Finds the minMax incremently
* +Player : players color for the ai
* -[BestX,BestY,BestXdest,BestYdest] : Set of best coordinates
* +PossibleMoves=[Move|Tail] : Possibles moves for the current depth level, Move is the move for the next point in the graph
* +MovesHistory : Array of moves to go to this point from the actual Board
* Depth : Depth level in the graph
*/
findMinMax(Player, [BestX,BestY,BestXdest,BestYdest], _, _, 0) :- !.
findMinMax(Player, [BestX,BestY,BestXdest,BestYdest], [], _, _) :- !.
findMinMax(Player, [BestX,BestY,BestXdest,BestYdest], [Move|Tail], MovesHistory, Depth) :-
	write('findMinMax at level : '), write(Depth),nl,
	append(MovesHistory, [Move], NewMovesHistory),
	simulateNextBoard(Player, NewMovesHistory),
	getPossibleMoves(Player, NewPossibleMoves),
	%write('New Moves : '), write(NewPossibleMoves),
	nextPlayer(Player, NextPlayer),
	NewDepth is Depth -1,
	findMinMax(NextPlayer, [BestX,BestY,BestXdest,BestYdest], NewPossibleMoves, NewMovesHistory, NewDepth),
	findMinMax(Player, [BestX,BestY,BestXdest,BestYdest], Tail, MovesHistory, Depth).


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
    getBoard(List),
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
