%% EAT %%
%%%%%%%%%%%%%%%%%% Now it is functionnal ^^

:-['checkEat.pl']. %import checkEat

doEat(Board, X, Y, NewX, NewY, NewBoard) :-
checkEat(Board, X, Y, XEaten,YEaten, NewX, NewY),
convertCoordinate(X, Y, PosEater),
convertCoordinate(XEaten, YEaten, PosEaten),
convertCoordinate(NewX, NewY, NewPos),
processEat(Board, PosEater, PosEaten, NewPos, NewBoard).

processEat(Board, PosEater, PosEaten, NewPos, NewBoard) :- 
findPiece(Board, PosEater, EaterPiece),
replace(Board, PosEater, em, NewBoardIntention),
replace(NewBoardIntention, PosEaten, em, NewBoardDigestion),
replace(NewBoardDigestion, NewPos, EaterPiece, NewBoard). 