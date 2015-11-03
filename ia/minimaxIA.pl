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
	findMinMax(Player, Player, [BestX,BestY,BestXdest,BestYdest], PossibleMoves, [], 2, null, null, _, [BestX, BestY, BestXdest, BestYdest]),
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
findMinMax(Player, Playing, [BestX,BestY,BestXdest,BestYdest], [Move|Tail], MovesHistory, 0, _, _, LeefScore, LeefMove) :-
	simulateNextBoard(Player, MovesHistory),
	evaluateBoard(Player, LeefScore),
	nth0(0, MovesHistory, LeefMove).

findMinMax(_, _, _, [], _, _, Score, MoveToProcess, Score, MoveToProcess):- !.

findMinMax(Player, Playing, [BestX,BestY,BestXdest,BestYdest], [Move|Tail], MovesHistory, Depth, Score, MoveToProcess, NewBestScore, NewBestMove) :-
	% Add this possible move to the move history for next leefs
	append(MovesHistory, [Move], NewMovesHistory),
	% Player because Player process the first move
	simulateNextBoard(Player, NewMovesHistory),
	nextPlayer(Playing, NextPlayer),
	% Get the possible moves of the next play (so, next player)
	getPossibleMoves(NextPlayer, NewPossibleMoves),
	NewDepth is Depth -1,
	findMinMax(Player, NextPlayer, [BestX,BestY,BestXdest,BestYdest], NewPossibleMoves, NewMovesHistory, NewDepth, null, null, NewScore, NewMove),
	findBestScore(Player, Playing, Score, NewScore, BestScore),
	findBestMove(Score, NewScore, BestScore, MoveToProcess, NewMove, BestMove),
	% Get the score of the leef,
	findMinMax(Player, Player, [BestX,BestY,BestXdest,BestYdest], Tail, MovesHistory, Depth, BestScore, BestMove, NewBestScore, NewBestMove).

% Maximiser
findBestScore(_, _, Score, null, Score):- !.
findBestScore(_, _, null, NewScore, NewScore):- !.
findBestScore(Player, Player, Score, NewScore, Score):-
	Score > NewScore,!.
findBestScore(Player, Player, Score, NewScore, NewScore).
% Minimiser
findBestScore(Player, _, Score, NewScore, NewScore):-
	Score > NewScore,!.
findBestScore(Player, _, Score, NewScore, Score).

%% Si = aléatoires entre les deux
findBestMove(_, _, _, null, NewMove, NewMove).
findBestMove(Score, _, Score, MoveToProcess, _, MoveToProcess).
findBestMove(_, NewScore, NewScore, _, NewMove, NewMove).

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
