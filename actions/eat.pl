%% EAT %%


% TODO : remplacer tous les zombies par des cases vides à la fin d.un tour

eatOnce(X, Y, NewX, NewY) :-
  checkEat(X, Y, XEaten,YEaten, NewX, NewY),
  convertCoordinate(X, Y, PosEater),
  convertCoordinate(NewX, NewY, NewPos),
  convertCoordinate(XEaten, YEaten, PosEaten),
  processEat(PosEater, PosEaten, NewPos).
%%END OF DO EAT

doEat(X, Y, NewX, NewY) :- eatOnce(X, Y, NewXTemp, NewYTemp), doEat(NewXTemp, NewYTemp, NewX, NewY);
                           eatOnce(X, Y, NewX, NewY).


%%END OF DO EAT (multiEat)

%% PROCESS EAT

% replace the eaten piece by a zombie, easier way to handle a whole game turn (if any pieces are eaten on the same game turn)
% don't forget to replace all zombies by empties at the end of the game turn

processEat(PosEater, PosEaten, NewPos) :-
  findPiece(PosEater, EaterPiece),
  b_getval(board, Board),
  replace(Board, PosEater, em, NewBoardIntention),
  replace(NewBoardIntention, PosEaten, zb, NewBoardDigestion),
  replace(NewBoardDigestion, NewPos, EaterPiece, NewBoard),
  b_setval(board, NewBoard).

%% CHECK EAT

% Fonction principale checkEat prend en compte les coordonnées

% ----------------------------------- CheckEat for coordinates
% L.ordre d.évaluation  des règles .est pas important si on ne fornit pas certains paramètres,
% Prolog va évaluer toutes les règles avec toutes les configurations possibles des valeurs pour voir s il peut rendre vrai l.ensemble des prédicats

%  règle qui converti les coordonnées en positions pour pouvoir reutiliser la fonction principale

checkEat(PosXEater, PosYEater, PosXNextCase, PosYNextCase) :-
  checkEat(PosXEater, PosYEater, _, _, PosXNextCase, PosYNextCase).
checkEat(PosXEater, PosYEater, PosXEaten, PosYEaten, PosXNextCase, PosYNextCase) :-
  convertCoordinate(PosXEater, PosYEater, PosEater),
  convertCoordinate(PosXEaten, PosYEaten, PosEaten),
  checkEat(PosEater, PosEaten, PosNextCase),
  convertCoordinate(PosXNextCase, PosYNextCase, PosNextCase).


%  ----------------------------------- Check for given Pieces positions
% TODO : Optimise algorithm to let Prolog find (unify) all eater and eatable piece configurations on Board
% ou sinon forcer Prolog à le faire en évaluant les règles d.IA pour obtenir le meilleur des cas

checkEat(PosEater, PosEaten, LandingPosCandidate) :-
  validPlayerPosition(PosEater, PosEaten, EaterPiece, EatenPiece),
  % -----------------------------------If queen, range will be allowed
  getPieceRange(EaterPiece, EaterRangeFactor),
  % -----------------------------------Check if eating is feasible
  checkNearPiecesToEat(PosEater, PosEaten, EaterRangeFactor, LandingPosCandidate),
  checkFreeWayToEat(LandingPosCandidate).


validPlayerPosition(PosEater, PosEaten, EaterPiece, EatenPiece) :-
  between(0, 99, PosEater),
  between(0, 99, PosEaten),
  PosEater - PosEaten \= 0,
  %  Find pieces that can be used for eating (eatable)
  findPiece(PosEater, EaterPiece),
  findPiece(PosEaten, EatenPiece),
  % check if opposite
  checkOpositePlayablePieces(EaterPiece, EatenPiece).

findPiece(PosPiece, Piece) :-
  between(0, 99, PosPiece),
  b_getval(board, Board),
  nth0(PosPiece, Board, Piece).

checkOpositePlayablePieces(EaterPiece, EatenPiece) :-
  opositePlayerPieces(EaterPiece, EatenPiece);
  opositePlayerPieces(EatenPiece, EaterPiece).

opositePlayerPieces(PieceA, PieceB) :-
  isWhite(PieceA),
  isBlack(PieceB).

getPieceRange(Piece, RangeFactor) :-
  isQueen(Piece), RangeFactor is 10;
  isPawn(Piece), RangeFactor is 1.

% START ----------------------------------- checkNearPiecesToEat
% We check for nearest pieces suitable for eating on the Diagonal lines and within the piece eating range
checkNearPiecesToEat(PosEater, PosEaten, EaterRangeFactor, LandingPosCandidate) :-
   % Eaten is on eaters diagonals
  piecesAreOnTheSameDiagonal(PosEater, PosEaten, LinesToTarget, DiagonalStepDistance),
  % Eaters Range is enough to reach eaten piece
  EaterRangeFactor >= abs(LinesToTarget),
  % Get line after eatens case to use for eater after jumping over
  getLinesToNewPosition(LinesToTarget, LinesToNewPosition),
  % As queen cannot eat a piece if theres another piece in between, we check the path to eaten is free as well
  noPiecesBetween(PosEater, LinesToTarget, DiagonalStepDistance, LinesToNewPosition - LinesToTarget),
  % Case to land eater after eating
  LandingPosCandidate is PosEater - DiagonalStepDistance * LinesToNewPosition.
% END ----------------------------------- checkNearPiecesToEat

% START ----------------------------------- piecesAreOnTheSameDiagonal
piecesAreOnTheSameDiagonal(PosEater, PosEaten, LinesToTarget, DiagonalStepDistance) :-
  % Evaluate PosEater regarding a (+/-) 9 or 11 Diagonal Range Factor
  diagonalStepDistance(DiagonalStepDistance),
  % If EatenPiece position is greater than EaterPiece position, we would just get a negative LinesToTarget factor
  LinesToTarget is div(PosEater - PosEaten, DiagonalStepDistance),
  0 is mod(PosEater - PosEaten, DiagonalStepDistance).
  % END ----------------------------------- piecesAreOnTheSameDiagonal

diagonalStepDistance(11). % For up left and down right case
diagonalStepDistance(9). % For up right and down left case

% ----------------------------------- getLinesToNewPosition
% règle qui calcule la prochaine case sur la diagonale, prennant en compte la position précédente  pour lui donner une direction

getLinesToNewPosition(LinesToTarget, LinesToNewPosition) :-
  LinesToTarget > 0, LinesToNewPosition is LinesToTarget + 1; % Get lower line on the Diagonal direction
  LinesToTarget < 0, LinesToNewPosition is LinesToTarget - 1. % Get upper line on the Diagonal direction

% ----------------------------------- noPiecesBetween
% On itère sur toutes les positions sur la diagonale entre la case de départ et la case de la pièce à manger
% pour vérifier qu.elles sont libres pour les passages notemment de la reine
% Dans le cas du pawn, la 1ère règle sera valide par défaut car il n.y a pas de distance superieure à 1 entre les 2 pièces
% et on n.évalue pas le reste, du coup

noPiecesBetween(PosEater, LinesToTarget, DiagonalStepDistance, CurrentLine) :-
  LinesToTarget is CurrentLine;
  NextPos is (PosEater - CurrentLine * DiagonalStepDistance),
  noPieceAt(NextPos),
  getLinesToNewPosition(CurrentLine, NextLine),
  noPiecesBetween(PosEater, LinesToTarget, DiagonalStepDistance, NextLine).

noPieceAt(NextPos) :-
  b_getval(board, Board),
  nth0(NextPos, Board, NextCase),
  isEmpty(NextCase).

 % Test check if LandingPosCandidate is Free
checkFreeWayToEat(LandingPosCandidate) :-
  findPiece(LandingPosCandidate, NextToEatenCase),
  isEmpty(NextToEatenCase).
%% END OF CHECK EAT
