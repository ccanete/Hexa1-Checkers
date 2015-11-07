:- consult("minimaxIA.pl").
:- consult("IALevelUno.pl").


% We use a simulated board, which is a copy of game board. We do the same to store player color who called the IA (computer).
% To between them we set state variable to indicate whether we're on IA Decision mode or gameplay mode,
% Depending on that, b_getval(board, Board) will send a simulated copy of current board variable or the actual current board
% if you're testing IA decisions during gameplay, set state variable to "board" to return gameplay board

heuristicIA(Player, BestX, BestY, BestXdest, BestYdest, DegradedMinReqGain, BestBranchGain):-
	setCallingIAPlayer(Player),
	initSimulationBoard,
	%initTempSimulationBoard,
	setState(simulation),
	findWorthestMove(BestX, BestY, BestXdest, BestYdest, -8, 4, DegradedMinReqGain, BestBranchGain, 50),
	setState(board).

% ---------------------------- STEP 4 : FORCE TO GET BRANCH WITH BEST POSSIBLE GAIN

% Use it to get the next best move for IA
% Check different decision branches, trying to get those with the R nearest to the max suitable gain, then degrade gain (R) expectations
findWorthestMove(X, Y, NewX, NewY, MinAcceptedGain, MinRequiredGain, DegradedMinReqGain, BestBranchGain, TurnDepth):-
	resetSimulationBoard, getCallingIAPlayer(IAPlayer), assessDecisionBranch(IAPlayer, X, Y, NewX, NewY, CurrentBranchGain, TurnDepth),
	nl, write('assessDecisionBranch :'), write(' Gain for IA = '), write(CurrentBranchGain),
	BestBranchGain is CurrentBranchGain, DegradedMinReqGain is CurrentBranchGain;!.
	%reviewDecisionBranch(X, Y, NewX, NewY, MinAcceptedGain, MinRequiredGain, DegradedMinReqGain, CurrentBranchGain, BestBranchGain, TurnDepth);!.
	
reviewDecisionBranch(X, Y, NewX, NewY, MinAcceptedGain, MinRequiredGain, DegradedMinReqGain, CurrentBranchGain, BestBranchGain, TurnDepth):-
	% CASE 1 : We reached MinRequiredGain on this try
	CurrentBranchGain >= MinRequiredGain,
	DegradedMinReqGain is MinRequiredGain, % Send How much we lost on requirement to reach a solution
	BestBranchGain is CurrentBranchGain; % Send Resulting Gain 
	
	% TODO : Change TurnDepth or apply different scenario gain strategy to allow it find a different solution
	% CASE 2 : We need to degrade MinRequiredGain and try again with a deeper Turn forecast to find a realistic (possible) solution
	MinRequiredGain >= MinAcceptedGain, NewTurnDepth is TurnDepth + 2, nl, 
	write('reviewDecisionBranch :'), write(' with TurnDepth = '), write(NewTurnDepth),
	findWorthestMove(X, Y, NewX, NewY, MinAcceptedGain, (MinRequiredGain -1), DegradedMinReqGain, BestBranchGain, NewTurnDepth);
	
	% CASE 3 : We reached MinAcceptedGain, so no point looking anymore, just send the best we could find
	CurrentBranchGain < MinAcceptedGain,
	BestBranchGain is CurrentBranchGain. % Or fail, because no suitable moves

% ---------------------------- STEP 3 : CALCULATE GAIN FOR A SERIES OF MVTS (FOR IA + ENEMY) (fonction appellé itérativement pour chaque noeud de décision)

% Gets the number of GainPointsForIA for a given decision path supposing both players take the best decisions at each turn
assessDecisionBranch(CurrentPlayer, X, Y, NewX, NewY, GainPointsForIA, CurrentTurnDepth):- 
	CurrentTurnDepth > 0, 
	
	% Assess best move for current player
	assessCurrentBestMove(CurrentPlayer, X, Y, NewX, NewY, GainPointsPlayerA),

	% Simulate this move on fake board
	processTurn(CurrentPlayer, X, Y, NewX, NewY),
	% Simulate on fake player shift
	nextPlayer(CurrentPlayer, NextPlayer),
	NextTurn is (CurrentTurnDepth-1),
	
	% Assess next probable move for NextPlayer (will try to take the best decision) - appel récursif à la mm règle
	assessDecisionBranch(NextPlayer, _, _, _, _, GainPointsPlayerB, NextTurn),
	GainPointsForIA is GainPointsPlayerA + GainPointsPlayerB.

% Assess last best move for this branch, without simulating because will give the branch result	
assessDecisionBranch(CurrentPlayer, X, Y, NewX, NewY, GainPointsForIA, 0):- 
	assessCurrentBestMove(CurrentPlayer, X, Y, NewX, NewY, GainPointsForIA).

% ---------------------------- STEP 2 : FIND BEST MOVE & ITS GAIN FOR IA

assessCurrentBestMove(Player, X, Y, Xdest, Ydest, GainPointsForIA) :-
	% Get best move for current player (max GainPoints from worthToEat comparison among all possible moves)
	levelUnoAI(Player, X, Y, Xdest, Ydest),

	% Assess how much points that move returns (to calculate GainPointsForIA)
	worthToPlay(Player, X, Y, Xdest, Ydest, GainPoints),

	% Assess if this points are in favor or against IA
	getIAPoints(Player, GainPoints, GainPointsForIA).

	%nl, write('assessCurrentBestMove (X:'), 
	%write(X), write(', Y:'), write(Y), 
	%write(', NewX:'), write(Xdest), write(', NewY:'), write(Ydest), 
	%write(', Gain:'), write(GainPointsForIA).

% ----------------------------------------------------------------------- TO BE CONTINUED

% TODO - findWorthestMove : instead of !, add the action that assess either that computer just lost / there's no more possible moves, then end game 