dynamic board/1.
board([wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
               nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
               wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
               nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
               em,nl,em,nl,em,nl,em,nl,em,nl,
               nl,em,nl,em,nl,em,nl,em,nl,em,
               bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
               nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,
               bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
               nl,bp,nl,bp,nl,bp,nl,bp,nl,bp]).

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

% Returns the User move
getUserMove(X,Y,NewX,NewY):-
  %TODO: Check between 1-10
  write('Enter the line number of the pawn you want to move (Y)'),nl,
  read(Y),
  write('Enter the column number of the pawn you want to move (X)'),nl,
  read(X),
  write('Enter the line number of the box you want to move to (NewY)'),nl,
  read(NewY),
  write('Enter the column number of the box you want to move to (NewX)'),nl,
  read(NewX).

nextPlayer(white,black).
nextPlayer(black, white).

% Check if a player has won
continuePlaying(Board):-
  continuePlaying(Board, white),
  continuePlaying(Board, black).
continuePlaying(Board, white):-
  member(wp, Board),!;member(wq, Board),!.
continuePlaying(Board, black):-
  member(bp, Board),!;member(bq, Board),!.
