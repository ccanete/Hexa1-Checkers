%% DO QUEEN %%
doQueen(Board, NewBoard, NewX, NewY):-
  %NewBoard is Board,
  checkQueen(Board, NewX, NewY),
  processQueen(Board, NewBoard, NewX, NewY),!.
doQueen(Board, Board, _, _).

% params :
checkQueen(Board, NewX, NewY):-
  getPiece(Board, NewX, NewY, Piece),
  checkQueen(Board, NewX, NewY, Piece).
checkQueen(Board, NewX, NewY, bp):-
    NewY = 1.
checkQueen(Board, NewX, NewY, wp):-
    NewY = 10.

% Predicate became queen (call it between turns not replays)
processQueen(Board, NewBoard, NewX, NewY) :-
  convertCoordinate(NewX, NewY, NewPos),
  getPiece(Board, NewX, NewY, P),
  convertQueen(P, Q),
  replace(Board, NewPos, Q, NewBoard).
processQueen(Board, Board, _, _).

%Convert to queen
convertQueen(bp,bq).
convertQueen(wp,wq).
