:- consult(simulationScenarios).

% Worth to eat basic case: after eating once, 
% we dont want to be eaten
% R is set to 1 if we can eat one piece, 
% or 0 if the same piece can be eaten afterwards

worthToEat(Board, BP, WP, R, NewBoard):- 
	canEat(Board, BP,WP, Rx), 
	simulateEat(Board, BP, WP, NewBoard), 
	canEat(NewBoard, WPy, BP, Ry), 
	R is -1;
	canEat(Board, BP,WP, Rx),
	simulateEat(Board, BP, WP, NewBoard), 
	not(canEat(NewBoard, WPy, BP, Ry)), 
	R is 1;
	canEat(Board, BP,WP, Rx), 
	simulateEat(Board, BP, WP, NewBoard), 
	becomesQueen(NewBoard, BP, Ry), 
	R is 2.

% TODO : include the predicate canMove 
% and wortToMove along with the upper rule

% Worth to eat basic case after T play: 
% after eating / moving several times,
% we want own eaten pieces be lower than player eaten pieces


worthToEat(Board, BP, WP, R, Rx, T):- 
	T > 0, 
	worthToEat(Board, BP, WP, Rt, NewBoard), 
	Tx is (T-1), 
	Rx is (R + Rt), 
	worthToEat(NewBoard, BP, WP, Rx, Ry, Tx);
	T is 0.

worthToEat(Board, BP, WP):- 
	between(1, 2, Tx), 
	worthToEat(Board, BP, WP, R, Tx), 
	R > 0.

% TODO : make above rule call itself iteratively for T turns 
% (canEat player piece, simulate and player canEat one of my pieces)

% TODO : for each of these cases, 
% calculate R(the total number of point for an iteration branch) 
% and P (The probability to get to that branch depending on player choices)

% TODO : Make prolog create a List with the results of R 
% for each taken branch, and a list with the probability 
% aggregation to get to each branch end 

% worthToMove(Board, pos1, pos2)
% worthToMove(Board, pos1, pos2, T)
