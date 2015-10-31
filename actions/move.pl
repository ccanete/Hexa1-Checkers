%% MOVE %%

doMove(X, Y, NewX, NewY) :-
  checkMove(X, Y, NewX, NewY),
  processMove(X, Y, NewX, NewY).

%Check Move
checkMove(X, Y, NewX, NewY):-
  %write('checkMove'),nl,
  checkBoarders(X, Y),
  checkBoarders(NewX, NewY),
  checkDestinationFree(NewX, NewY),
  getPiece(X, Y, PieceToMove),
  checkPieceMove(PieceToMove, X, Y, NewX, NewY).

% Process Move after having check rules
processMove(X, Y, NewX, NewY) :-
  convertCoordinate(X, Y, Pos),
  convertCoordinate(NewX, NewY, NewPos),
  b_getval(board, Board),
  nth0(Pos, Board, Piece),
  replace(Board, Pos, em, TempBoard),
  replace(TempBoard, NewPos, Piece, NewBoard),
  b_setval(board, NewBoard).

%Helpers
checkDestinationFree(NewX, NewY):-
  getPiece(NewX, NewY, DestinationPiece),
  DestinationPiece == em.

checkPieceMove(wp, X, Y, NewX, NewY):-
  %write('checkMove wp'),nl,
  AcceptedX1 is X+1, AcceptedX2 is X-1,
  AcceptedY is Y+1,
  (AcceptedX1 == NewX; AcceptedX2 == NewX),
  AcceptedY == NewY.

checkPieceMove(bp, X, Y, NewX, NewY):-
  %write('checkMove bp'),nl,
  AcceptedX1 is X-1, AcceptedX2 is X+1,
  AcceptedY is Y-1,
  (AcceptedX1 == NewX; AcceptedX2 == NewX),
  AcceptedY == NewY.
