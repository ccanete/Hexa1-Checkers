:- consult(simulationScenarios).

% Worth to eat basic case: after eating once, 
% we dont want to be eaten

% R is set to 1 if we can eat one piece, 
% or 0 if the same piece can be eaten afterwards


worthToEat(Board, BP, WP, R):- 
	canEat(Board, BP,WP, Rx), 
	simulateEat(Board, BP, WP, NewBoard), 
	canEat(NewBoard, WP, BP, Ry), 
	Rx - Ry > 0, 
	R is 0; 
	canEat(Board, BP,WP, Rx), 
	simulateEat(Board, BP, WP, NewBoard), 
	becomesQueen(NewBoard, BP, Ry), 
	Ry - Rx > 0, 
	R is 1.


% TODO : include the predicate canMove 
% and worthToMove along with the upper rule

% Worth to eat basic case after T play: 
% after eating / moving several times,
% we want own eaten pieces be lower than 
% player eaten pieces


worthToEat(Board, BP, WP, R, T):- 
	worthToEat(Board, BP, WP, R).

worthToEat(Board, BP, WP):- 
	between(1, 2, Tx), 
	worthToEat(Board, BP, WP, R, Tx), 
	R >= 1.


% TODO : make above rule call itself iteratively for T turns 
% (canEat player piece, simulate and player canEat one of my pieces)

% TODO : for each of these cases, calculate 
% R(the total number of point for an iteration branch) 
% and P (The probability to get to that branch depending on player choices)

% TODO : Make prolog create a List with the results of R 
% for each taken branch, and a list with the probability 
% aggregation to get to each branch end 

%worthToMove(Board, pos1, pos2)
%worthToMove(Board, pos1, pos2, T)
