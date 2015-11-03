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
	initSimulationBoard,
	setState(simulation),
	getPossibleMoves(Player, PossibleMoves),
	findMinMax(Player, Player, [BestX,BestY,BestXdest,BestYdest], PossibleMoves, [], 2, Score, [[BestX, BestY, BestXdest, BestYdest]|_]),
	setState(board).

/**
* findBestPlayMinMax/5
* Finds the minMax incremently
* +Player : players color for the ai
* +Playing : Player who plays the simulate turn
* -[BestX,BestY,BestXdest,BestYdest] : Set of best coordinates
* +PossibleMoves=[Move|Tail] : Possibles moves for the current depth level, Move is the move for the next point in the graph
* +MovesHistory : Array of moves to go to this point from the actual Board
* +Depth : Depth level in the graph
* -Score : The score of the leef
*/
% Deepest level (leef level), need to get the board evaluation and return it.
findMinMax(Player, Playing, [BestX,BestY,BestXdest,BestYdest], [Move|Tail], MovesHistory, 0, LeefScore, _) :-
	simulateNextBoard(Player, MovesHistory),
	evaluateBoard(Player, LeefScore).
findMinMax(Player, Playing, [BestX,BestY,BestXdest,BestYdest], [], _, _, end, _) :- !.
findMinMax(Player, Playing, [BestX,BestY,BestXdest,BestYdest], [Move|Tail], MovesHistory, Depth, BestScore, MoveToProcess) :-
	%write('findMinMax at level : '), write(Depth),nl,
	% Add this possible move to the move history for next leefs
	append(MovesHistory, [Move], NewMovesHistory),
	% Player because Player process the first move
	simulateNextBoard(Player, NewMovesHistory),
	nextPlayer(Playing, NextPlayer),
	% Get the possible moves of the next play (so, next player)
	getPossibleMoves(NextPlayer, NewPossibleMoves),
	NewDepth is Depth -1,
	findMinMax(Player, NextPlayer, [BestX,BestY,BestXdest,BestYdest], NewPossibleMoves, NewMovesHistory, NewDepth, LeefScore, _),
	% Get the score of the leef
	findMinMax(Player, Player, [BestX,BestY,BestXdest,BestYdest], Tail, MovesHistory, Depth, Score, _),
	findBestScore(Player, Playing, LeefScore, Score, BestScore),
	findMoveToProcess(LeefScore, Score, BestScore, [Move], Tail, MoveToProcess).

% Maximiser
findBestScore(_, _, end, Score, Score):- !.
findBestScore(_, _, LeefScore, end, LeefScore):- !.
findBestScore(Player, Player, LeefScore, Score, LeefScore):-
	LeefScore > Score,!.
findBestScore(Player, Player, LeefScore, Score, Score).
% Minimiser
findBestScore(Player, _, LeefScore, Score, Score):-
	LeefScore > Score,!.
findBestScore(Player, _, LeefScore, Score, LeefScore).

%% Si = aléatoires entre les deux

findMoveToProcess(LeefScore, _, LeefScore, [Move], _, [Move]).
findMoveToProcess(_, Score, Score, _, Tail, Tail).

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
