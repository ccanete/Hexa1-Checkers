%% MOVE %%

%% TODO : DoMove

%Check Move
checkMove(Board, X, Y, NewX, NewY, white):-
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  Piece == em,
  OldX is X+1,
  OldY is Y+1,
  write('X : '),
  write(OldX),nl,
  write('Y : '),
  write(OldY),nl,
  NewX == OldX,
  NewY == OldY.

checkMove(Board, X, Y, NewX, NewY, white):-
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  Piece == em,
  OldX is X+1,
  OldY is Y-1,
  write('X : '),
  write(OldX),nl,
  write('Y : '),
  write(OldY),nl,
  NewX == OldX,
  NewY == OldY.

checkMove(Board, X, Y, NewX, NewY, black):-
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  Piece == em,
  OldX is X-1,
  OldY is Y-1,
  write('X : '),
  write(OldX),nl,
  write('Y : '),
  write(OldY),nl,
  NewX == OldX,
  NewY == OldY.

checkMove(Board, X, Y, NewX, NewY, black):-
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  Piece == em,
  OldX is X-1,
  OldY is Y+1,
  write('X : '),
  write(OldX),nl,
  write('Y : '),
  write(OldY),nl,
  NewX == OldX,
  NewY == OldY.

% Process Move after having check rules
processMove(Board, X, Y, NewX, NewY, NewBoard) :-
  convertCoordinate(X, Y, Pos),
  convertCoordinate(NewX, NewY, NewPos),
  nth0(Pos, Board, Piece),
  replace(Board, Pos, em, TempBoard),
  replace(TempBoard, NewPos, Piece, NewBoard).
