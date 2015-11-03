%% === Helpers === %%

% pieceFacts
isQueen(bq).
isQueen(wq).
isPawn(bp).
isPawn(wp).
isWhite(wp).
isWhite(wq).
isBlack(bp).
isBlack(bq).
isEmpty(em).
isPiece(Case) :- isPawn(Case); isQueen(Case).

setState(State) :-
  b_setval(state, State).
getState(State) :-
  b_getval(state, State).

getBoard(Board):-
  getState(State),
  getBoard(Board, State).
getBoard(Board, board):-
  b_getval(board, Board).
getBoard(Board, simulation):-
  b_getval(simulation, Board).

setBoard(NewBoard):-
  getState(State),
  setBoard(NewBoard, State).
setBoard(NewBoard, board):-
  b_setval(board, NewBoard).
setBoard(NewBoard, simulation):-
  b_setval(simulation, NewBoard).

% Return the piece at X, Y coordinate in the Board
getPiece(X, Y, Piece) :-
  convertCoordinate(X, Y, Pos),
  getBoard(Board), % create Board locally with global board
  nth0(Pos, Board, Piece).

% Convert coordinate to array index (index starts at 1)
convertCoordinate(X, Y, Pos):-
  checkBoarders(X, Y),
  Pos is ((Y-1) * 10 + (X-1)).

% Check if the coordinate are in the board
checkBoarders(X, Y) :-
  between(1, 10, X),
  between(1, 10, Y).

% Replace an element in an array. (Board, Index, NexElement, NewBoard)
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).
