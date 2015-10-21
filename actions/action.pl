%% MOVE %%
% Process Move after having check rules
processMove(Board, X, Y, NewX, NewY, NewBoard) :-
  convertCoordinate(X, Y, Pos),
  %write('Pos : '),
  %write(Pos), nl,
  convertCoordinate(NewX, NewY, NewPos),
  %write('NewPos : '),
  %write(NewPos), nl,
  nth0(Pos, Board, Piece),
  replace(Board, Pos, em, TempBoard),
  replace(TempBoard, NewPos, Piece, NewBoard).

%% EAT %%
% Not functionnal
processEat(Board, X, Y, NewX, NewY, NewBoard) :-
  XEaten is (X+NewX)/2,
  YEaten is (Y+NewY)/2,
  convertCoordinate(XEaten, YEaten, Pos),
  replace(Board, Pos, em, NewBoard).
