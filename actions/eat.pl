%% EAT %%
% Not functionnal
processEat(X, Y, NewX, NewY) :-
  XEaten is (X+NewX)/2,
  YEaten is (Y+NewY)/2,
  convertCoordinate(XEaten, YEaten, Pos),
  b_getval(board, Board),
  replace(Board, Pos, em, NewBoard),
  b_setval(board, NewBoard).

%doEat(Board, X, Y, NewX, NewY, NewBoard).
doEat( _, _, _, _).
