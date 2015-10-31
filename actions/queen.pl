%% DO QUEEN %%
doQueen(NewX, NewY):-
  %NewBoard is Board,
  checkQueen(NewX, NewY),
  processQueen(NewX, NewY),!.
doQueen(_, _).

% params :
checkQueen(NewX, NewY):-
  getPiece(NewX, NewY, Piece),
  checkQueen(NewY, Piece).
checkQueen(NewY, bp):-
    NewY = 1.
checkQueen(NewY, wp):-
    NewY = 10.

% Predicate became queen (call it between turns not replays)
processQueen(NewX, NewY) :-
  convertCoordinate(NewX, NewY, NewPos),
  getPiece(NewX, NewY, P),
  convertQueen(P, Q),
  b_getval(board, Board),
  replace(Board, NewPos, Q, NewBoard),
  b_setval(board, NewBoard).
processQueen(_, _).

%Convert to queen
convertQueen(bp,bq).
convertQueen(wp,wq).
