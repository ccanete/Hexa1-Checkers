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
	getPossibleMoves(Player, PossibleMoves),
	findMinMax(Player, [BestX,BestY,BestXdest,BestYdest], PossibleMoves, [], 2).

/**
* findBestPlayMinMax/5
* Finds the minMax incremently
* +Player : players color for the ai
* -[BestX,BestY,BestXdest,BestYdest] : Set of best coordinates
* +PossibleMoves=[Move|Tail] : Possibles moves for the current depth level, Move is the move for the next point in the graph
* +MovesHistory : Array of moves to go to this point from the actual Board
* Depth : Depth level in the graph
*/
findMinMax(Player, [BestX,BestY,BestXdest,BestYdest], [Move|Tail], MovesHistory, Depth) :-
	write('findMinMax at level : '), write(Depth),nl,
	write(MovesHistory),nl,
	write(Move),nl,
	append([Move], MovesHistory, NewMovesHistory)),
	write(NewMovesHistory),
	write("simulateBoard"),nl,
	%simulateBoard(NewMovesHistory),
	%getSimulatedPossibleMoves(Player, SimulatedPossibleMoves),
	NewDepth is Depth -1,
	findMinMax(Player, [BestX,BestY,BestXdest,BestYdest], SimulatedPossibleMoves, NewMovesHistory, NewDepth),
	findMinMax(Player, [BestX,BestY,BestXdest,BestYdest], Tail, Depth).
findMinMax(Player, [BestX,BestY,BestXdest,BestYdest], [], 0) :- !.


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
