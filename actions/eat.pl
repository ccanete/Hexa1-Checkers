%% EAT %%
% Not functionnal
processEat(Board, X, Y, NewX, NewY, NewBoard) :-
  XEaten is (X+NewX)/2,
  YEaten is (Y+NewY)/2,
  convertCoordinate(XEaten, YEaten, Pos),
  replace(Board, Pos, em, NewBoard).
