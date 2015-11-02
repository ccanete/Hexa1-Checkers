% Simulate board 

:- discontiguous bin(wp1,nul,wp3,nul,wp5,
				     nul,wp2,nul,emp,nul,
					 emp,nul,emp,nul,emp,
					 nul,bp2,nul,bp4,nul,
					 bp1,nul,bp3,nul,bp5).

% We simulate movement and eattest functions with facts, 
% because we dont have the actual code					 

% Simulate board where we can eat one piece  
:- discontiguous bce(wp1,nul,wp3,nul,wp5,
				     nul,wp2,nul,emp,nul,
					 emp,nul,wp4,nul,emp,
					 nul,bp2,nul,bp4,nul,
					 bp1,nul,bp3,nul,bp5).
canEat(bce, bp2, wp4, 1).
simulateEat(bce, bp2, wp4, bae).

% Simulate board where we can be eaten by another piece
:- discontiguous bae(wp1,nul,wp3,nul,wp5,
				     nul,wp2,nul,bp2,nul,
					 emp,nul,emp,nul,emp,
					 nul,emp,nul,bp4,nul,
					 bp1,nul,bp3,nul,bp5).
canEat(bae, wp5, bp2, 1).


% Simulate board where we can eat one piece  
:- discontiguous bceT1(wp1,nul,wp3,nul,emp,
				      nul,wp2,nul,emp,nul,
					  emp,nul,wp5,nul,emp,
					  nul,emp,nul,bp4,nul,
					  bp1,nul,bp3,nul,bp5).
canEat(bceT1, _, _, 0).

% Simulate board where we can eat one piece  
:- discontiguous bceT1a(wp1,nul,wp3,nul,emp,
				      nul,wp2,nul,emp,nul,
					  emp,nul,wp5,nul,bp4,
					  nul,emp,nul,emp,nul,
					  bp1,nul,bp3,nul,bp5).
canEat(bceT1a, _, _, 0).

% Simulate board where we can eat one piece  
:- discontiguous bceT1aa(wp1,nul,emp,nul,emp,
				      nul,wp2,nul,wp3,nul,
					  emp,nul,wp5,nul,bp4,
					  nul,emp,nul,emp,nul,
					  bp1,nul,bp3,nul,bp5).
canEat(bceT1aa, bp4, wp3, 0).
becomesQueen(bceT1aa, bp4, 5).
simulateEat(bceT1aa, bp4, wp3, bceT1aa).

% Simulate board where we can eat one piece  
:- discontiguous bceT1b(wp1,nul,wp3,nul,emp,
						nul,wp2,nul,emp,nul,
						emp,nul,wp5,nul,emp,
						nul,bp3,nul,bp4,nul,
						bp1,nul,emp,nul,bp5).
canEat(bceT1b, bp3, wp5, 1).
simulateEat(bceT1b, bp3, wp5, bceT1bb).

% Simulate board where we can eat one piece
:- discontiguous bceT1ba(wp1,nul,wp3,nul,emp,
						nul,emp,nul,emp,nul,
						wp2,nul,wp5,nul,emp,
						nul,bp3,nul,bp4,nul,
						bp1,nul,emp,nul,bp5).
canEat(bceT1ba, bp3, wp5, 1).
simulateEat(bceT1ba, bp3, wp5, bceT1bab).
canEat(bceT1ba, bp4, wp5, 1).
simulateEat( bceT1ba, bp4, wp5, bceT1bac).
canEat(bceT1ba, wp2, bp3, 1).
canEat(bceT1ba, wp2, bp4, 1).
becomesQueen(bceT1ba, wp2, 5).
simulateEat(bceT1ba, wp2, BP, bceT1ba).

:- discontiguous bceT1baa(wp1,nul,wp3,nul,emp,
						nul,emp,nul,emp,nul,
						emp,nul,wp5,nul,wp2,
						nul,emp,nul,emp,nul,
						bp1,nul,emp,nul,bp5).
canEat(bceT1baa, _, _, 0).

:- discontiguous bceT1bab(wp1,nul,wp3,nul,emp,
						nul,emp,nul,bp3,nul,
						wp2,nul,emp,nul,emp,
						nul,emp,nul,bp4,nul,
						bp1,nul,emp,nul,bp5).
canEat(bceT1bab, wp3, bp3, 1).

:- discontiguous bceT1bac(wp1,nul,wp3,nul,emp,
						nul,bp4,nul,emp,nul,
						wp2,nul,emp,nul,emp,
						nul,bp3,nul,emp,nul,
						bp1,nul,emp,nul,bp5).
canEat(bceT1bac, wp2, bp3, 1).
canEat(bceT1bac, wp3, bp4, 1).
becomesQueen(bceT1bac, wp2, 5).
simulateEat(bceT1bac, wp2, BP, bceT1bac).

:- discontiguous bceT1bb(wp1,nul,wp3,nul,emp,
						nul,wp2,nul,bp3,nul,
						emp,nul,emp,nul,emp,
						nul,emp,nul,bp4,nul,
						bp1,nul,emp,nul,bp5).
canEat(bceT1bb, wp3, bp3, 1).
canEat(bceT1bb, wp3, bp4, 1).
becomesQueen(bceT1bb, wp3, 5).
becomesQueen(bceT1bb, bp3, 5).
simulateEat(bceT1bb, wp3, BP, bceT1bb).
simulateEat(bceT1bb, bp3, BP, bceT1bb).

% Simulate board where we can eat one piece  
:- discontiguous bceT1c(wp1,nul,wp3,nul,emp,
						nul,wp2,nul,emp,nul,
						emp,nul,wp5,nul,emp,
						nul,bp1,nul,bp4,nul,
						emp,nul,bp3,nul,bp5).
canEat(bceT1c, bp1, wp5, 1).
simulateEat(bceT1c, bp1, wp5, bceT1cb).
canEat(bceT1c, wp5, bp1, 1).
becomesQueen(bceT1c, wp5, 5).
simulateEat(bceT1c, wp5, _, bceT1c).

% Simulate board where we can eat one piece  
:- discontiguous bceT1ca(wp1,nul,wp3,nul,emp,
						nul,emp,nul,emp,nul,
						wp2,nul,wp5,nul,emp,
						nul,bp1,nul,bp4,nul,
						emp,nul,bp3,nul,bp5).
canEat(bceT1ca, bp1, wp5, 1).
simulateEat(bceT1ca, bp1, wp5, bceT1caa).
canEat(bceT1ca, bp4, wp5, 1).
simulateEat(bceT1ca, bp1, wp5, bceT1cab).

% Simulate board where we can eat one piece  
:- discontiguous bceT1caa(wp1,nul,wp3,nul,emp,
						nul,emp,nul,bp1,nul,
						wp2,nul,emp,nul,emp,
						nul,emp,nul,bp4,nul,
						emp,nul,bp3,nul,bp5).
canEat(bceT1caa, wp3, bp1, 1).

% Simulate board where we can eat one piece  
:- discontiguous bceT1cab(wp1,nul,wp3,nul,emp,
						nul,bp4,nul,emp,nul,
						wp2,nul,emp,nul,emp,
						nul,bp1,nul,emp,nul,
						emp,nul,bp3,nul,bp5).
canEat(bceT1cab, wp1, bp4, 1).
canEat(bceT1cab, wp1, bp1, 1).
becomesQueen(bceT1cab, wp1, 5).
simulateEat(bceT1cab, bp1, wp5, bceT1cab).

:- discontiguous bceT1cb(wp1,nul,wp3,nul,emp,
						nul,wp2,nul,bp1,nul,
						emp,nul,emp,nul,emp,
						nul,emp,nul,bp4,nul,
						emp,nul,bp3,nul,bp5).
canEat(bceT1cb, wp3, bp1, 1).
becomesQueen(bceT1cb, bp1, 5).
simulateEat(bceT1cb, bp1, _, bceT1cb).

% Simulate board where we can eat one piece  
:- discontiguous bceT1cab(wp1,nul,wp3,nul,emp,
						nul,emp,nul,bp1,nul,
						wp2,nul,emp,nul,emp,
						nul,emp,nul,bp4,nul,
						emp,nul,bm3,nul,bp5).
canEat(bceT1cab, wp3, bp1, 1).
becomesQueen(bceT1cab, bp1, 5).
simulateEat(bceT1cab, bp1, _, bceT1cab).

