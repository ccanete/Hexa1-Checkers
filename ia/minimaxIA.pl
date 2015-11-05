/**********************************
			MINIMAX AI
***********************************/

/**
* minmaxIA/5
* Returns the best move for minmax AI
* +Player : color player for the ai
* +X, +Y : piece
* -Xdest, -Ydest : best move found
*/
minmaxIA(Player, BestX, BestY, BestXdest, BestYdest):-
	initSimulationBoard,
	setState(simulation),
	getPossibleMoves(Player, PossibleMoves),
	findMinMax(Player, Player, PossibleMoves, [], 2, null, null, _, [BestX, BestY, BestXdest, BestYdest]),
	setState(board).

/**
* findBestPlayMinMax/5
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
findMinMax(Player, _, _, MovesHistory, 0, _, _, LeefScore, LeefMove) :-
	simulateNextBoard(Player, MovesHistory),
	evaluateBoard(Player, LeefScore),
	nth0(0, MovesHistory, LeefMove).
%% If no more move because a player wins
findMinMax(Player, Player, [], MovesHistory, _, null, null, -10000, LeefMove):-
	nth0(0, MovesHistory, LeefMove).
findMinMax(Player, _, [], MovesHistory, _, null, null, 10000, LeefMove):-
	nth0(0, MovesHistory, LeefMove).
%% Return to the previous level the best score at this depth
findMinMax(_, _, [], _, _, Score, MoveToProcess, Score, MoveToProcess):- !.
%% Recursive function that go throught the tree algorithm
findMinMax(Player, Playing, [Move|Tail], MovesHistory, Depth, Score, MoveToProcess, NewBestScore, NewBestMove) :-
	% Add this possible move to the move history for next levels
	append(MovesHistory, [Move], NewMovesHistory),
	% Player process the first move
	simulateNextBoard(Player, NewMovesHistory),
	nextPlayer(Playing, NextPlayer),
	% Get the possible moves of the next play (so, next player)
	getPossibleMoves(NextPlayer, NewPossibleMoves),
	NewDepth is Depth -1,
	% Recursive call to the algorithm to a deeper level
	findMinMax(Player, NextPlayer, NewPossibleMoves, NewMovesHistory, NewDepth, null, null, NewScore, NewMove),
	% Compare the fetched score of a leef to the previous leef scores
	findBestScore(Player, Playing, Score, NewScore, BestScore),
	% Select the involved move of the best score leef determined before
	findBestMove(Score, NewScore, BestScore, MoveToProcess, NewMove, BestMove),
	% Call the algorithm for the next leef at this level
	findMinMax(Player, Player, Tail, MovesHistory, Depth, BestScore, BestMove, NewBestScore, NewBestMove).

/**
* findBestScore/5
* Returns the best score depends of the level:
* 	If the current player is the player who calls the algorithm, it returns the best score
* 	Else, it returns the lowest
* +Player : player who calls the algorithm
* +Playing : player who plays the current turn
* +Score : The previous best registered score
* +NewScore : The new calculated score
* -BestScore : Best score between the both
*/
findBestScore(_, _, Score, null, Score):- !.
findBestScore(_, _, null, NewScore, NewScore):- !.
% Same player
findBestScore(Player, Player, Score, NewScore, Score):-
	Score > NewScore,!.
findBestScore(Player, Player, Score, NewScore, NewScore).
% Oposite player
findBestScore(Player, _, Score, NewScore, NewScore):-
	Score > NewScore,!.
findBestScore(Player, _, Score, NewScore, Score).
% Possible amelioration : if Score = NewScore, random selection beetween both

findBestMove(_, _, _, null, NewMove, NewMove).
findBestMove(Score, _, Score, MoveToProcess, _, MoveToProcess).
findBestMove(_, NewScore, NewScore, _, NewMove, NewMove).

%% TODO: AMELIORATIONS
%% Under a number of pieces, should always eat
%% If ennemi closed to a queen piece, should be eaten !

/**
* evaluateBoard/2
* Calculte a Player's score
* -Score : Player's score for a board
*/
evaluateBoard(Player, Score) :-
	countPieces(NBwp, NBwq, NBbp, NBbq),
	%countPieceOnQueenBox(wpOnQueen, NBwpOnQueen),
	%countPieceOnQueenBox(bpOnQueen, NBbpOnQueen),
	evaluateBoard(Player, Score, NBwp,NBwq, NBbp ,NBbq, 0, 0).

evaluateBoard(white, 10000, _,_, 0 ,0, _, _).
evaluateBoard(white, -10000, 0, 0, _, _, _, _).
evaluateBoard(black, 10000, 0, 0, _, _, _, _).
evaluateBoard(black, -10000, _,_, 0 ,0, _, _).

evaluateBoard(white, Score, NBwp,NBwq, NBbp ,NBbq, NBwpOnQueen, NBbpOnQueen):-
	Score is 3*NBwq - 3*NBbq + 2*NBwpOnQueen - 2*NBbpOnQueen + NBwp - NBbp.

evaluateBoard(black, Score, NBwp,NBwq, NBbp ,NBbq, NBwpOnQueen, NBbpOnQueen):-
	Score is - 3*NBwq + 3*NBbq - 2*NBwpOnQueen + 2*NBbpOnQueen - NBwp + NBbp.


/**
* countPieceOnQueen/2
* counts the number of piece on a queen box
*
*/
countPieceOnQueenBox(white, Res):-
	getBoard(Board),
	countPieceBetweenIndex(Board, wp, Res, 0, 1, 10, 1).
countPieceOnQueenBox(black, Res):-
	getBoard(Board),
	countPieceBetweenIndex(Board, bp, Res, 0, 91, 100, 1).

countPieceBetweenIndex([Piece|Tail], Piece, Res, Counter, MinIndex, MaxIndex, Index):-
	!,
	between(MinIndex, MaxIndex, Index),
	countPieceBetweenIndex(Tail, Piece, Res, Counter+1, MinIndex, MaxIndex, Index+1).
countPieceBetweenIndex([_|Tail], Piece, Res, Counter, MinIndex, MaxIndex, Index):-
	between(MinIndex, MaxIndex, Index),
	countPieceBetweenIndex(Tail, Piece, Res, Counter, MinIndex, MaxIndex, Index+1).
countPieceBetweenIndex([_|Tail], Piece, Res, Counter, MinIndex, MaxIndex, Index):-
	countPieceBetweenIndex(Tail, Piece, Res, Counter, MinIndex, MaxIndex, Index+1).
% for the end of List
countPieceBetweenIndex([], _, Counter, Counter, _, _, _) :- !.

/**
* count/2
* counts the number Piece are on the board
*
*/
countPieces(NBwp, NBwq, NBbp, NBbq) :-
  getBoard(List),
  countL(List, NBwp, NBwq, NBbp, NBbq, 0, 0, 0, 0).

countL( [], NBwp, NBwq, NBbp, NBbq, NBwp, NBwq, NBbp, NBbq):-	!.
% When Piece is found
countL( [wp|Xs], NBwp, NBwq, NBbp, NBbq, CountNBwp, CountNBwq, CountNBbp, CountNBbq) :-
	!,
	NewCountNBwp is CountNBwp + 1,
  countL(Xs, NBwp, NBwq, NBbp, NBbq, NewCountNBwp, CountNBwq, CountNBbp, CountNBbq).

countL( [wq|Xs], NBwp, NBwq, NBbp, NBbq, CountNBwp, CountNBwq, CountNBbp, CountNBbq) :-
	!,
	NewCountNBwq is CountNBwq + 1,
  countL(Xs, NBwp, NBwq, NBbp, NBbq, CountNBwp, NewCountNBwq, CountNBbp, CountNBbq).

countL( [bp|Xs], NBwp, NBwq, NBbp, NBbq, CountNBwp, CountNBwq, CountNBbp, CountNBbq) :-
	!,
	NewCountNBbp is CountNBbp + 1,
  countL(Xs, NBwp, NBwq, NBbp, NBbq, CountNBwp, CountNBwq, NewCountNBbp, CountNBbq).

countL( [bq|Xs], NBwp, NBwq, NBbp, NBbq, CountNBwp, CountNBwq, CountNBbp, CountNBbq) :-
	!,
	NewCountNBbq is CountNBbq + 1,
  countL(Xs, NBwp, NBwq, NBbp, NBbq, CountNBwp, CountNBwq, CountNBbp, NewCountNBbq).

% When Piece is not found
countL( [_|Xs], NBwp, NBwq, NBbp, NBbq, CountNBwp, CountNBwq, CountNBbp, CountNBbq) :-
	%write("null"),
  countL(Xs, NBwp, NBwq, NBbp, NBbq, CountNBwp, CountNBwq, CountNBbp, CountNBbq).
