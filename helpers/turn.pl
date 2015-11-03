% The initial board (origin box : lower left corner of the board)
initBoard :-
    b_setval(board, [wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
             nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
             wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,
             nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,
             em,nl,em,nl,em,nl,em,nl,em,nl,
             nl,em,nl,em,nl,em,nl,em,nl,em,
             bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
             nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,
             bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
             nl,bp,nl,bp,nl,bp,nl,bp,nl,bp]).

% nl : null (unaccessible box)
% em : free box
% bq : black queen
% wq : white queen
% bp : black pawn
% wp : white pawn

% First, we try to eat, if not possible, we try to move
processTurn(Player, X, Y, NewX, NewY):-
  doEat(X, Y, NewX, NewY),
  doQueen(NewX, NewY),
  zombieToEmpty.
processTurn(Player, X, Y, NewX, NewY):-
  doMove(X, Y, NewX, NewY),
  doQueen(NewX, NewY),
  zombieToEmpty.

userMove(X,Y,NewX,NewY):-
  getUserMove(X,Y,NewX,NewY),
  (checkEat(X, Y, _, _, NewX, NewY);checkMove(X, Y, NewX, NewY)).
userMove(X,Y,NewX,NewY):-
  nl,write('This move is impossible, please, try another one:'),nl,nl,
  userMove(X,Y,NewX,NewY).

% Returns the User move
getUserMove(X,Y,NewX,NewY):-
  %TODO: Check between 1-10
  write('Enter the column number of the pawn you want to move (X)'),nl,
  read(X),
  write('Enter the line number of the pawn you want to move (Y)'),nl,
  read(Y),
  write('Enter the column number of the box you want to move to (NewX)'),nl,
  read(NewX),
  write('Enter the line number of the box you want to move to (NewY)'),nl,
  read(NewY).

nextPlayer(white,black).
nextPlayer(black, white).

% Replace all of the zombies pieces to empties at the end of any game turn
zombieToEmpty:-
  getBoard(Board),
  nth0(Pos, Board, zb),
  replace(Board, Pos, em, NewBoard),
  setBoard(NewBoard),
  zombieToEmpty.
zombieToEmpty.

% Check if a player has won
continuePlaying:-
  getBoard(Board),
  continuePlaying(Board, white),
  continuePlaying(Board, black).
continuePlaying(Board, white):-
  member(wp, Board),!;member(wq, Board),!.
continuePlaying(Board, black):-
  member(bp, Board),!;member(bq, Board),!.

% Check if a player has won
getWinner(Winner):-
  getBoard(Board),
  getWinner(Board, white, Winner),
  getWinner(Board, black, Winner).
getWinner(Board, white, black):-
  not(member(wp, Board)),
  not(member(wq, Board)).
getWinner(Board, black, white):-
  not(member(bp, Board)),
  not(member(bq, Board)).
