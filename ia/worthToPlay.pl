:- consult("../helpers/turn.pl").
:- consult("../helpers/util.pl").
:- consult("../helpers/rules.pl").
:- consult("../actions/eat.pl").
:- consult("../actions/move.pl").
:- consult("../actions/queen.pl").
:- consult("helpersIA.pl").
:- consult("minimaxIA.pl").
:- consult("IALevelUno.pl").

heuristicIA(Player, BestX, BestY, BestXdest, BestYdest, DegradedMinReqGain, BestBranchGain):-
	setCallingIAPlayer(Player),
	initSimulationBoard,
	%initTempSimulationBoard,
	setState(simulation),
	findWorthestMove(BestX, BestY, BestXdest, BestYdest, -8, 4, DegradedMinReqGain, BestBranchGain, 5),
	setState(board).


% -------------------------- SUPPORT FUNCTIONS ---------------------- %
resetSimulationBoard:-
	b_getval(board, Board),
  	b_setval(simulation, Board).

initTempSimulationBoard:-
	b_getval(simulation, Board),
  	b_setval(tempSimulation, Board).

resetTempSimulationBoard:-
	b_getval(tempSimulation, Board),
  	b_setval(simulation, Board).

setCallingIAPlayer(Player):-
	b_setval(callingIAPlayer, Player).

getCallingIAPlayer(Player):-
	b_getval(callingIAPlayer, Player).

% ---------------------------- STEP 4 : FORCE TO GET BRANCH WITH BEST POSSIBLE GAIN

% Use it to get the next best move for IA
% Check different decision branches, trying to get those with the R nearest to the max suitable gain, then degrade gain (R) expectations
findWorthestMove(X, Y, NewX, NewY, MinAcceptedGain, MinRequiredGain, DegradedMinReqGain, BestBranchGain, TurnDepth):-
	resetSimulationBoard, getCallingIAPlayer(IAPlayer), assessDecisionBranch(IAPlayer, X, Y, NewX, NewY, CurrentBranchGain, TurnDepth), 
	reviewDecisionBranch(X, Y, NewX, NewY, MinAcceptedGain, MinRequiredGain, DegradedMinReqGain, CurrentBranchGain, BestBranchGain, TurnDepth);!.
	
reviewDecisionBranch(X, Y, NewX, NewY, MinAcceptedGain, MinRequiredGain, DegradedMinReqGain, CurrentBranchGain, BestBranchGain, TurnDepth):-
	% CASE 1 : We reached MinRequiredGain on this try
	CurrentBranchGain >= MinRequiredGain,
	DegradedMinReqGain is MinRequiredGain, % Send How much we lost on requirement to reach a solution
	BestBranchGain is CurrentBranchGain; % Send Resulting Gain 
	
	% TODO : Change TurnDepth or apply different scenario gain assignation to allow it find a different solution
	% CASE 2 : We need to degrade MinRequiredGain and try again with a deeper Turn forecast to find a realistic (possible) solution
	MinRequiredGain >= MinAcceptedGain,
	findWorthestMove(X, Y, NewX, NewY, MinAcceptedGain, (MinRequiredGain -1), DegradedMinReqGain, BestBranchGain, (TurnDepth + 2 ) );
	
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
	processTurn(CurrentPlayer, X, Y, NewX, NewY), % WARNING : doesn't seems to take care of cases where we can only Eat or Move but not become queen, will fail
	% Simulate on fake player shift
	nextPlayer(CurrentPlayer, NextPlayer),
	NextTurn is (CurrentTurnDepth-1),
	
	% Assess next probable move for NextPlayer (will try to take the best decision) - appel récursif à la mm règle
	assessDecisionBranch(NextPlayer, NextPlayerX, NextPlayerY, NextPlayerNewX, NextPlayerNewY, GainPointsPlayerB, NextTurn), GainPointsForIA is GainPointsPlayerA + GainPointsPlayerB.

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

% ---------------------------- STEP 1 : DEFINE TYPES OF GAINS

% Assess how much points a player can win from a given Move scenario

worthToPlay(X, Y, NewX, NewY, GainPoints):- getCallingIAPlayer(Player), worthToPlay(Player, X, Y, NewX, NewY, GainPoints).

worthToPlay(Player, X, Y, NewX, NewY, GainPoints):-
	checkFewPieces(Player), checkMove(X, Y, NewX, NewY), checkQueen(NewX, NewY), GainPoints is 10;
	checkFewPieces(Player), worthToEat(X, Y, NewX, NewY, EatPoints), GainPoints is EatPoints + 2;
	checkFewPieces(Player), checkMove(X, Y, NewX, NewY), GainPoints is -1;
	%checkFewPieces(Player), checkProtectPawn(X, Y, NewX, NewY), GainPoints is 8;
	%checkFewPieces(Player), checkBlockEnemyAdvance(X, Y, NewX, NewY), GainPoints is 5;
	checkMove(X, Y, NewX, NewY), checkQueen(NewX, NewY), GainPoints is 5;
	worthToEat(X, Y, NewX, NewY, GainPoints);
	checkMove(X, Y, NewX, NewY), GainPoints is 0.
	% checkProtectPawn(X, Y, NewX, NewY), GainPoints is 3;
	% checkBlockEnemyAdvance(X, Y, NewX, NewY), GainPoints is 1.

% TODO : Scenarios
% TODO : Consequences
% TODO : Contexts => Add as well the fact that there're several moves with same gain


worthToEat(X, Y, NewX, NewY, GainPoints):-
	% CASE 1 : We can eat more than once
	checkEatGain(X, Y, IntermX, IntermY, FirstEatPoints),
	initTempSimulationBoard, eatOnce(X, Y, IntermX, IntermY),
	worthToEat(IntermX, IntermY, NewX, NewY, NextEatPoints), 
	GainPoints is (FirstEatPoints + NextEatPoints);
	
	% CASE 2 : We can only eat once
	resetTempSimulationBoard,
	checkEatGain(X, Y, NewX, NewY, GainPoints).

checkEatGain(X, Y, NewX, NewY, GainPoints):- checkEat(X, Y, NewX, NewY), checkQueen(NewX, NewY), GainPoints is 7.
checkEatGain(X, Y, NewX, NewY, GainPoints):- checkEat(X, Y, NewX, NewY), GainPoints is 2.
% TODO : check case might be eaten after the move (simulate)

% Increase or decrease certain decision importance according to remaining player pieces
checkFewPieces(Player):-
	evaluateBoard(Player, Score), Score =< 5.

checkLotOfPieces(Player):-
	evaluateBoard(Player, Score), Score > 10.

checkEnoughPieces(Player):-
	evaluateBoard(Player, Score), Score > 5, Score =< 10.

getIAPoints(Player, GainPoints, R):-
	playerIsEnemy(Player), R is (GainPoints * (-1)); % Invert points against IA for an enemy action
	playerIsIA(Player), R is GainPoints.

playerIsEnemy(Player):- getCallingIAPlayer(AnotherPlayer), nextPlayer(AnotherPlayer, Player).
playerIsIA(Player):- getCallingIAPlayer(Player).
