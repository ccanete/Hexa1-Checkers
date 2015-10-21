%TODO : Restore pieceFacts import
%:-['pieceFacts.pl'].
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
