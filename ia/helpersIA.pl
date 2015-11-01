/********************************
			HELPERS IA
********************************/

% This file contains common methods for the different IAs

/**
* Returns all the differents moves for a Player
* +Player : player color
* -PossibleMoves : list of possible couple(X,Y) moves
*
*/
getPossibleMoves(Player, PossibleMoves):-
	findall([X,Y, NewX, NewY], (checkPlay(Player, X, Y, NewX, NewY)), PossibleMoves).

%% Functions to set the IA level %%
getIALevel(Level):-
  nl,write('Please choose an AI level :.'),nl,
	displayLevels,
	read(Level),
  checkIALevel(Level).
getIALevel(Level):-
  nl,write('Sorry, this AI level does not exist.'),nl,
  getIALevel(Level).

checkIALevel(Level):-
	between(0, 1, Level).

displayLevels:-
	write('Level 0: Random AI'),nl,
	write('Level 1: Easy AI'),nl.
