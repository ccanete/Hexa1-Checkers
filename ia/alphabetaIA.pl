/**********************************
		ALPHA BETA AI
**********************************/

/**
* alphabetaIA/5
* Returns the best move for minmax AI
* +Player : color player for the ai
* +X, +Y : piece
* -Xdest, -Ydest : best move found
*/
alphabetaIA(Player, BestX, BestY, BestXdest, BestYdest):-
	initSimulationBoard,
	setState(simulation),
	getPossibleMoves(Player, PossibleMoves),
	findMinMaxAB(Player, Player, PossibleMoves, [], 3, null, null, _, [BestX, BestY, BestXdest, BestYdest]),
	setState(board).

/**
* findBestPlayMinMax/9
* Determines the best move to play using a minmax algorithm
* +Player : Color of the player who call the function
* +Playing : Player who plays the turn during the simulation
* +PossibleMoves=[Move|Tail] : Possibles moves for the current depth level, Move is the move for the next point in the graph
* +MovesHistory : Array of moves to go to this point from the actual Board
* +Depth : Depth level in the graph
* -Score : Return to a higher level the score of the board for a leef of the algorithm tree
* -MoveToProcess : First move to play to go to this leef
* -NewBestScore : Best score fetched during the algorithm
* -NewBestMove : First move to play to go to the high score leef
*/
%% Deepest level (leef level), calculates the board evaluation and returns it (LeefScore, LeefMove)
findMinMaxAB(Player, _, _, MovesHistory, 0, _, _, LeefScore, LeefMove) :-
	simulateNextBoard(Player, MovesHistory),
	evaluateBoard(Player, LeefScore),
	nth0(0, MovesHistory, LeefMove).
%% If no more move because a player wins
findMinMax(Player, Player, [], MovesHistory, _, null, null, -10000, LeefMove):-
	nth0(0, MovesHistory, LeefMove).
findMinMax(Player, _, [], MovesHistory, _, null, null, 10000, LeefMove):-
	nth0(0, MovesHistory, LeefMove).
%% Return to the previous level the best score at this depth
findMinMaxAB(_, _, [], _, _, Score, MoveToProcess, Score, MoveToProcess):- !.
%% Recursive function that go throught the tree algorithm
findMinMaxAB(Player, Playing, [Move|Tail], MovesHistory, Depth, Score, MoveToProcess, NewBestScore, NewBestMove) :-
	% Add this possible move to the move history for next levels
	append(MovesHistory, [Move], NewMovesHistory),
	% Player process the first move
	simulateNextBoard(Player, NewMovesHistory),
	nextPlayer(Playing, NextPlayer),
	% Get the possible moves of the next play (so, next player)
	getPossibleMoves(NextPlayer, NewPossibleMoves),
	NewDepth is Depth -1,
	% Recursive call to the algorithm to a deeper level
	findMinMaxAB(Player, NextPlayer, NewPossibleMoves, NewMovesHistory, NewDepth, null, null, NewScore, NewMove),

	
	% Compare the fetched score of a leef to the previous leef scores
	findBestScore(Player, Playing, Score, NewScore, BestScore),
	% Select the involved move of the best score leef determined before
	findBestMove(Score, NewScore, BestScore, MoveToProcess, NewMove, BestMove),

	alphaBetaCheck(Player, NewBestScore, BestScore),!,
	
	% Call the algorithm for the next leef at this level
	findMinMaxAB(Player, Player, Tail, MovesHistory, Depth, BestScore, BestMove, NewBestScore, NewBestMove).

	% We need to compare the new score to the above level score
	


/**
* +Player : Must be the AI turn so the AI is black
* +NewBestScore : The leaf score
* +BestScore : the score from the upper level
*/
alphaBetaCheck(black, NewBestScore, BestScore) :-
	NewScore < Score,
	write('Coupure alpha'),nl,!.

alphaBetaCheck(white, NewBestScore, BestScore) :-
	NewScore > Score,
	write('Coupure beta'),nl,!.
