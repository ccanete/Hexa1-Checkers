
% Worth to eat basic case: after eating once, 
% we dont want to be eaten

% R is set to 1 if we can eat one piece, 
% or 0 if the same piece can be eaten afterwards

% TODO : include the predicate canMove 
% and worthToMove along with the upper rule

worthToMove(X, Y, NewX, NewY, R):-
	checkMove(X, Y, NewX, NewY).

