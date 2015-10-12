%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Checkers game             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main function
initGame:-
  initBoard(Board),
  %% test eat and move
  write('--- GAME 1 ---'),nl,
  printBoard(Board),
  play(Board, 4, 2, 2, 4, white),
  write('--- GAME 2 ---'),nl,
  printBoard(Board),
  play(Board, 1, 1, 2, 10, white).

% Piece : the piece you are looking for
play(Board, X, Y, NewX, NewY, Color):-
  checkMove(Board, X, Y, NewX, NewY, Color),
  processMove(Board, X, Y, NewX, NewY, BoardAfterMove),
  printBoard(BoardAfterMove),
  % BE CAREFULL, IF NO EAT WHAT BOARD SHOULD BE USED ?
  %checkEat(Board, X, Y, NewX, NewY),
  processEat(BoardAfterMove, X, Y, NewX, NewY, BoardAfterEat),
  printBoard(BoardAfterEat),
  doQueen(BoardAfterEat, BoardAfterQueen, NewX, NewY),
  printBoard(BoardAfterQueen),
  continuePlaying(BoardAfterQueen),
  write('Play again !').

% The initial board (origin box : lower left corner of the board)
initBoard(Board) :-
      Board = [wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
      				 nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
      				 wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
      				 nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
      				 em,nl,em,nl,em,nl,em,nl,em,nl,
      				 nl,em,nl,em,nl,em,nl,em,nl,em,
      				 bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
      				 nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,
      				 bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
      				 nl,bp,nl,bp,nl,bp,nl,bp,nl,bp].

% nl : null (unaccessible box)
% em : free box
% bq : black queen
% wq : white queen
% bp : black pawn
% wp : white pawn
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


% Check if a player has won
continuePlaying(Board):-
  continuePlaying(Board, white),
  continuePlaying(Board, black).
continuePlaying(Board, white):-
  member(wp, Board),!;member(wq, Board),!.
continuePlaying(Board, black):-
  member(bp, Board),!;member(bq, Board),!.

% Process Move after having check rules
processMove(Board, X, Y, NewX, NewY, NewBoard) :-
  convertCoordinate(X, Y, Pos),
  %write('Pos : '),
  %write(Pos), nl,
  convertCoordinate(NewX, NewY, NewPos),
  %write('NewPos : '),
  %write(NewPos), nl,
  nth0(Pos, Board, Piece),
  replace(Board, Pos, em, TempBoard),
  replace(TempBoard, NewPos, Piece, NewBoard).

%% DO QUEEN %%
doQueen(Board, NewBoard, NewX, NewY):-
  %NewBoard is Board,
  checkQueen(Board, NewX, NewY),
  becameQueen(Board, NewBoard, NewX, NewY),!.
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
becameQueen(Board, NewBoard, NewX, NewY) :-
  convertCoordinate(NewX, NewY, NewPos),
  getPiece(Board, NewX, NewY, P),
  convertQueen(P, Q),
  replace(Board, NewPos, Q, NewBoard).
becameQueen(Board, Board, _, _).

%Convert to queen
convertQueen(bp,bq).
convertQueen(wp,wq).

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

% CheckEat for coordinates
checkEat(Board, PosXEater, PosYEater, PosXEaten, PosYEaten, PosXNextCase, PosYNextCase) :-
  convertCoordinate(PosXEater, PosYEater, PosEater),
  convertCoordinate(PosXEaten, PosYEaten, PosEaten),
  checkEat(Board, PosEater, PosEaten, PosNextCase),
  convertCoordinate(PosXNextCase, PosYNextCase, PosNextCase).


% Check for given Pieces positions
% TODO : Optimise algorithm to let Prolog find (unify) all eater and eatable piece configurations on Board 
checkEat(Board, PosEater, PosEaten, LandingPosCandidate) :-
  validPlayerPosition(Board, PosEater, PosEaten, EaterPiece, EatenPiece),

  % If queen, range will be allowed
  getPieceRange(EaterPiece, EaterRangeFactor),
  
  % Check if eating is feasible
  checkNearPiecesToEat(Board, PosEater, PosEaten, EaterRangeFactor, LandingPosCandidate),
  checkFreeWayToEat(Board, LandingPosCandidate).


validPlayerPosition(Board, PosEater, PosEaten, EaterPiece, EatenPiece) :-
  between(0, 99, PosEater), between(0, 99, PosEaten),  PosEater - PosEaten \= 0,
  
  % Find pieces that can be used for eating
  findPiece(Board, PosEater, EaterPiece),
  findPiece(Board, PosEaten, EatenPiece),
  checkOpositePlayablePieces(EaterPiece, EatenPiece).

findPiece(Board, PosPiece, Piece) :-
  between(0, 99, PosPiece), nth0(PosPiece, Board, Piece).

checkOpositePlayablePieces(EaterPiece, EatenPiece) :-
  opositePlayerPieces(EaterPiece, EatenPiece);
  opositePlayerPieces(EatenPiece, EaterPiece).

opositePlayerPieces(PieceA, PieceB) :- isWhite(PieceA), isBlack(PieceB).

getPieceRange(Piece, RangeFactor) :-
  isQueen(Piece), RangeFactor is 10;
  isPawn(Piece), RangeFactor is 1.

% We check for nearest pieces suitable for eating on the Diagonal lines and within the piece eating range
checkNearPiecesToEat(Board, PosEater, PosEaten, EaterRangeFactor, LandingPosCandidate) :-
   % Eaten is on eaters diagonals
  haveExactLinesToTarget(PosEater, PosEaten, LinesToTarget, DiagonalStepDistance),
  % Eaters Range is enough to reach eaten piece
  EaterRangeFactor >= abs(LinesToTarget), 

  % Get line after eatens case to use for eater after jumping over
  getLinesToNewPosition(LinesToTarget, LinesToNewPosition), 

  % As queen cannot eat a piece if theres another piece in between, we check the path to eaten is free as well
  noPiecesBetween(Board, PosEater, LinesToTarget, DiagonalStepDistance, LinesToNewPosition - LinesToTarget),

  % Case to land eater after eating
  LandingPosCandidate is PosEater - DiagonalStepDistance * LinesToNewPosition.

haveExactLinesToTarget(PosEater, PosEaten, LinesToTarget, DiagonalStepDistance) :-
  % Evaluate PosEater regarding a (+/-) 9 or 11 Diagonal Range Factor
  diagonalStepDistance(DiagonalStepDistance),

  % If EatenPiece position is greater than EaterPiece position, we would just get a negative LinesToTarget factor
  LinesToTarget is div(PosEater - PosEaten, DiagonalStepDistance),
  0 is mod(PosEater - PosEaten, DiagonalStepDistance).

diagonalStepDistance(11). % For up left and down right case
diagonalStepDistance(9). % For up right and down left case

getLinesToNewPosition(LinesToTarget, LinesToNewPosition) :- 
  LinesToTarget > 0, LinesToNewPosition is LinesToTarget + 1; % Get lower line on the Diagonal direction
  LinesToTarget < 0, LinesToNewPosition is LinesToTarget - 1. % Get upper line on the Diagonal direction

noPiecesBetween(Board, PosEater, LinesToTarget, DiagonalStepDistance, CurrentLine) :-
  LinesToTarget is CurrentLine;
  NextPos is (PosEater - CurrentLine * DiagonalStepDistance),
  noPieceAt(NextPos, Board),
  getLinesToNewPosition(CurrentLine, NextLine),
  noPiecesBetween(Board, PosEater, LinesToTarget, DiagonalStepDistance, NextLine).
  
noPieceAt(NextPos, Board) :- nth0(NextPos, Board, NextCase), isEmpty(NextCase).
 
 % Test check if LandingPosCandidate is Free 
checkFreeWayToEat(Board, LandingPosCandidate) :-
  findPiece(Board, LandingPosCandidate, NextToEatenCase), isEmpty(NextToEatenCase).
 
% Not functionnal
processEat(Board, X, Y, NewX, NewY, NewBoard) :-
  XEaten is (X+NewX)/2,
  YEaten is (Y+NewY)/2,
  convertCoordinate(XEaten, YEaten, Pos),
  replace(Board, Pos, em, NewBoard).

% Return the piece at X, Y coordinate in the Board
getPiece(Board, X, Y, Piece) :-
  convertCoordinate(X, Y, Pos),
  nth0(Pos, Board, Piece).

%% === Helpers === %%

% Replace an element in an array. (Board, Index, NexElement, NewBoard)
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

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

% Convert coordinate to array index (index starts at 1)
convertCoordinate(Line, Column, Pos):-
  checkBoarders(Line, Column),
  Pos is ((Line-1) * 10 + Column-1).

checkBoarders(Line, Column) :-
  between(1, 10,Line),
  between(1, 10, Column).

% Convert pice code to graphic symbol
pieceToSymbol(nl, '  ').
pieceToSymbol(em, '  ').
pieceToSymbol(bq, 'B ').
pieceToSymbol(wq, 'W ').
pieceToSymbol(bp, 'b ').
pieceToSymbol(wp, 'w ').
pieceToSymbol(Piece, '# ').

%% === Print functions === %%

% Start printing the board recursivly (loop style)
printBoard(Board) :-
  write('+----------------------------+'),nl,
  printBoard(Board, 1), !.
% Calls the PrintLine function and iterates
printBoard(Board, Line) :-
  printLine(Board, Line),
  printGrid,
  NextLine is Line + 1,
  printBoard(Board, NextLine).
% End of the loop
printBoard( _, 11) :-
  write('+----------------------------+'),nl,!.

% Print a seperation line
printGrid :-
  write('|--+--+--+--+--+--+--+--+--+--|'), nl.

% Start printing a line recursivly (loop style)
printLine(Board, Line) :-
   write('|'),
   printLine(Board, Line, 1).
% Print a piece of the line then recursiv call
printLine(Board, Line, Col) :-
  getPiece(Board, Line, Col, Piece),
  pieceToSymbol(Piece, Symbol),
  write(Symbol),
  write('|'),
  NextCol is Col + 1,
  printLine(Board, Line, NextCol).
% End of the loop
printLine( _, _, 11) :- nl,!.

%% === End of the Game === %%
%% TODO
% End of game
  % No more white
  % No more black
  % No more possible move
 %end(Board) :-

 %noMore(Board, Color) :-
  % Regarder dans le cours comment parcourir une liste
