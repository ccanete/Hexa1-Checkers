%% MOVE %%

%% TODO : DoMove

%Check Move
checkMove(Board, X, Y, NewX, NewY, white):-
  write('checkMove 1'),nl,
  % get the pice in the destination box
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  % check if the box is empty
  Piece == em,
  AcceptedX is X+1,
  AcceptedY is Y+1,
  AcceptedX == NewX,
  AcceptedY == NewY.

checkMove(Board, X, Y, NewX, NewY, white):-
  write('checkMove 1'),nl,
  % get the pice in the destination box
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  % check if the box is empty
  Piece == em,
  AcceptedX is X-1,
  AcceptedY is Y+1,
  AcceptedX == NewX,
  AcceptedY == NewY.

checkMove(Board, X, Y, NewX, NewY, black):-
  write('checkMove 1'),nl,
  % get the pice in the destination box
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  % check if the box is empty
  Piece == em,
  AcceptedX is X-1,
  AcceptedY is Y-1,
  AcceptedX == NewX,
  AcceptedY == NewY.

checkMove(Board, X, Y, NewX, NewY, black):-
  write('checkMove 1'),nl,
  % get the pice in the destination box
  getPiece(Board, NewX, NewY, Piece),
  write('piece : '),
  write(Piece),nl,
  % check if the box is empty
  Piece == em,
  AcceptedX is X+1,
  AcceptedY is Y-1,
  AcceptedX == NewX,
  AcceptedY == NewY.

% Process Move after having check rules
processMove(Board, X, Y, NewX, NewY, NewBoard) :-
  convertCoordinate(X, Y, Pos),
  convertCoordinate(NewX, NewY, NewPos),
  nth0(Pos, Board, Piece),
  replace(Board, Pos, em, TempBoard),
  replace(TempBoard, NewPos, Piece, NewBoard).
