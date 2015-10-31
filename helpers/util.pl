%% === Helpers === %%

% Return the piece at X, Y coordinate in the Board
getPiece(X, Y, Piece) :-
  convertCoordinate(X, Y, Pos),
  b_getval(board, Board),
  nth0(Pos, Board, Piece).

% Convert coordinate to array index (index starts at 1)
convertCoordinate(X, Y, Pos):-
  checkBoarders(X, Y),
  Pos is ((Y-1) * 10 + (X-1)).

%% Check if the coordinate are in the board
checkBoarders(X, Y) :-
  between(1, 10, X),
  between(1, 10, Y).

% Replace an element in an array. (Board, Index, NexElement, NewBoard)
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).
