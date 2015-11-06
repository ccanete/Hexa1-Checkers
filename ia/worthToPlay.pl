:- consult("../helpers/turn.pl").
:- consult("../helpers/util.pl").
:- consult("../helpers/rules.pl").
:- consult("../actions/eat.pl").
:- consult("../actions/move.pl").
:- consult("../actions/queen.pl").
:- consult("helpersIA.pl").


% ---------------------------- STEP 1 : DEFINE TYPES OF GAINS

% Assess how much points a player can win from a given Move scenario

worthToPlay(X, Y, NewX, NewY, GainPoints):- getCallingIAPlayer(Player), worthToPlay(Player, X, Y, NewX, NewY, GainPoints).

worthToPlay(Player, X, Y, NewX, NewY, GainPoints):-
	checkFewPieces(Player), checkMove(X, Y, NewX, NewY), checkQueen(NewX, NewY), GainPoints is 10;
	checkFewPieces(Player), checkEatGain(X, Y, NewX, NewY, EatPoints), GainPoints is EatPoints + 2;
	checkFewPieces(Player), checkMove(X, Y, NewX, NewY), GainPoints is -1;
	%checkFewPieces(Player), checkProtectPawn(X, Y, NewX, NewY), GainPoints is 8;
	%checkFewPieces(Player), checkBlockEnemyAdvance(X, Y, NewX, NewY), GainPoints is 5;
	checkMove(X, Y, NewX, NewY), checkQueen(NewX, NewY), GainPoints is 5;
	checkEatGain(X, Y, NewX, NewY, GainPoints);
	checkMove(X, Y, NewX, NewY), GainPoints is 0.
	% checkProtectPawn(X, Y, NewX, NewY), GainPoints is 3;
	% checkBlockEnemyAdvance(X, Y, NewX, NewY), GainPoints is 1.

% Evaluate worthToEat without impacting current simulated board
simulatedWorthToEat(X, Y, NewX, NewY, GainPoints):-
	holdSimulationBoard, worthToEat(X, Y, NewX, NewY, GainPoints), resetHoldSimulationBoard.

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
checkEatGain(X, Y, NewX, NewY, GainPoints):- checkEat(X, Y, NewX, NewY), checkQueen(NewX, NewY), GainPoints is 7.
checkEatGain(X, Y, NewX, NewY, GainPoints):- checkEat(X, Y, NewX, NewY), checkQueen(NewX, NewY), GainPoints is 7.
checkEatGain(X, Y, NewX, NewY, GainPoints):- checkEat(X, Y, NewX, NewY), GainPoints is 2.

% Increase or decrease certain decision importance according to remaining player pieces
checkFewPieces(Player):-
	evaluateBoard(Player, Score), Score =< 3.

checkLotOfPieces(Player):-
	evaluateBoard(Player, Score), Score > 5.

checkEnoughPieces(Player):-
	evaluateBoard(Player, Score), Score > 3, Score =< 5.

getIAPoints(Player, GainPoints, R):-
	playerIsEnemy(Player), R is (GainPoints * (-1)); % Invert points against IA for an enemy action
	playerIsIA(Player), R is GainPoints.

playerIsEnemy(Player):- getCallingIAPlayer(AnotherPlayer), nextPlayer(AnotherPlayer, Player).
playerIsIA(Player):- getCallingIAPlayer(Player).

% ----------------------------------------------------------------------- TO BE CONTINUED

% TODO - worthToPlay : - add more cases to worthToPlay like checkProtectPawn, checkBlockEnemyAdvance and assign a value according to game strategy...
%					   - check case might be eaten after the move (simulate)
%					   - WARNING : restablish previous Simulated board
%					   - distribute rules per cathegory to add, reduce and ponderate Gains :
% IMPLEMENT AS : Scenarios 		- Add
% IMPLEMENT AS : Consequences 	- Reduce / Increase
% IMPLEMENT AS : Contexts  		- Ponderate => Add as well the fact that there're several moves with same gain
% IMPLEMENT AS : Strategies 	- Target preferred (mulicriteria analysis with satisfaction threshold for each scenario from common game statistics)

% TODO - checkFewPieces : - IMPLEMENT getAlivePieces from player instead of Score (evaluateBoard)
%						  - Take into account remaining turns and compare with remaining pieces, 