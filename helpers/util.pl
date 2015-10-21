%% === Helpers === %%

% Return the piece at X, Y coordinate in the Board
getPiece(Board, X, Y, Piece) :-
  convertCoordinate(X, Y, Pos),
  nth0(Pos, Board, Piece).

% Convert coordinate to array index (index starts at 1)
convertCoordinate(Line, Column, Pos):-
  checkBoarders(Line, Column),
  Pos is ((Line-1) * 10 + Column-1).

%% Check if the coordinate are in the board
checkBoarders(Line, Column) :-
  between(1, 10,Line),
  between(1, 10, Column).

%% OLD convertCoordinate code
/*
% Convert coordinate to array index (index starts at 1)
convertCoordinate(Line, Column, Pos):-
  %write('Line : '),
  %write(Line), nl,
  %write('Column : '),
  %write(Column), nl,
  Line =< 10,
  Line >= 1,
  Column >= 1,
  Column =< 10,
  Pos is (Line-1) * 10 + Column-1.
*/


% Replace an element in an array. (Board, Index, NexElement, NewBoard)
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).
