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
	findMinMax(Player, Player, [BestX,BestY,BestXdest,BestYdest], PossibleMoves, [], 2),
	setState(board).

/**
* findBestPlayMinMax/5
* Finds the minMax incremently
* +Player : players color for the ai
* +Playing : Player who plays the simulate turn
* -[BestX,BestY,BestXdest,BestYdest] : Set of best coordinates
* +PossibleMoves=[Move|Tail] : Possibles moves for the current depth level, Move is the move for the next point in the graph
* +MovesHistory : Array of moves to go to this point from the actual Board
* Depth : Depth level in the graph
*/
% Deepest level (leef level), need to get the board evaluation and return it.
findMinMax(Player, Playing, [BestX,BestY,BestXdest,BestYdest], MovesHistory, _, 0) :-
	write('findMinMax at level : '), write("0"),nl,
	simulateNextBoard(Player, NewMovesHistory),
	%printBoard,
	evaluateBoard(Player, Score),
	write(Score).
findMinMax(Player, Playing, [BestX,BestY,BestXdest,BestYdest], [], _, _) :- !.
findMinMax(Player, Playing, [BestX,BestY,BestXdest,BestYdest], [Move|Tail], MovesHistory, Depth) :-
	write('findMinMax at level : '), write(Depth),nl,
	% Add this possible move to the move history for next leefs
	append(MovesHistory, [Move], NewMovesHistory),
	% Player because Player process the first move
	simulateNextBoard(Player, NewMovesHistory),
	nextPlayer(Playing, NextPlayer),
	% Get the possible moves of the next play (so, next player)
	getPossibleMoves(NextPlayer, NewPossibleMoves),
	NewDepth is Depth -1,
	findMinMax(Player, NextPlayer, [BestX,BestY,BestXdest,BestYdest], NewPossibleMoves, NewMovesHistory, NewDepth),
	findMinMax(Player, Player, [BestX,BestY,BestXdest,BestYdest], Tail, MovesHistory, Depth).


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
