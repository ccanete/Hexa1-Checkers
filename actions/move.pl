%% MOVE %%

doMove(Board, X, Y, NewX, NewY, NewBoard) :-
  checkMove(Board, X, Y, NewX, NewY),
  processMove(Board, X, Y, NewX, NewY, NewBoard).

%Check Move
checkMove(Board, X, Y, NewX, NewY):-
  write('checkMove'),nl,
  checkBoarders(X, Y),
  checkBoarders(NewX, NewY),
  checkDestinationFree(Board, NewX, NewY),
  getPiece(Board, X, Y, PieceToMove),
  checkPieceMove(PieceToMove, X, Y, NewX, NewY).

checkDestinationFree(Board, NewX, NewY):-
  getPiece(Board, NewX, NewY, DestinationPiece),
  DestinationPiece == em.

checkPieceMove(wp, X, Y, NewX, NewY):-
  write('checkMove wp'),nl,
  AcceptedX1 is X+1,
  AcceptedX2 is X-1,
  AcceptedY is Y+1,
  (AcceptedX1 == NewX; AcceptedX2 == NewX),
  AcceptedY == NewY.

checkPieceMove(bp, X, Y, NewX, NewY):-
  write('checkMove bp'),nl,
  AcceptedX1 is X-1,
  AcceptedX2 is X+1,
  AcceptedY is Y-1,
  (AcceptedX1 == NewX; AcceptedX2 == NewX),
  AcceptedY == NewY.

% Process Move after having check rules
processMove(Board, X, Y, NewX, NewY, NewBoard) :-
  convertCoordinate(X, Y, Pos),
  convertCoordinate(NewX, NewY, NewPos),
  nth0(Pos, Board, Piece),
  replace(Board, Pos, em, TempBoard),
  replace(TempBoard, NewPos, Piece, NewBoard).
