%% MOVE %%
% Process Move after having check rules
processMove(Board, X, Y, NewX, NewY, NewBoard) :-
  convertCoordinate(X, Y, Pos),
  convertCoordinate(NewX, NewY, NewPos),
  nth0(Pos, Board, Piece),
  replace(Board, Pos, em, TempBoard),
  replace(TempBoard, NewPos, Piece, NewBoard).
