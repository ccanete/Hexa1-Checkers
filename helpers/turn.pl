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
processTurn(_,_,_,_,_):- !.


%% Set Players %%
setPlayer(PlayerNumber, 0) :-
    b_setval(PlayerNumber, human).
setPlayer(PlayerNumber, 1) :-
    b_setval(PlayerNumber, randomIA).
setPlayer(PlayerNumber, 2) :-
    b_setval(PlayerNumber, minmax).
setPlayer(PlayerNumber, 3) :-
    b_setval(PlayerNumber, alphabeta).
setPlayer(PlayerNumber, 4) :-
    b_setval(PlayerNumber, heuristic).

%% Functions to set the IA level %%
getPlayer(Player, Number):-
  nl,write('Please choose the Player '), write(Number), write(" : "), nl,
	displayPlayers,
	read(Player),
  checkPlayerLevel(Player).
getPlayer(Level):-
  nl,write('Sorry, this Player does not exist.'),nl,
  getPlayer(Level).

checkPlayerLevel(Player):-
	between(0, 4, Player).

displayPlayers:-
	write('Player 0: Human'),nl,
	write('Player 1: Random AI'),nl,
	write('Player 2: Minmax AI'),nl,
	write('Player 3: AlphaBeta AI'),nl,
  write('Player 4: Heuristic AI'),nl.

nextPlayerTurn(1, 2, NextPlayer):-
  b_getval(player2, NextPlayer).
nextPlayerTurn(2, 1, NextPlayer):-
  b_getval(player1, NextPlayer).

getPlayerMove(human, _, X, Y, NewX, NewY):-
  userMove(X,Y,NewX,NewY).

getPlayerMove(IAPlayer, Color, X, Y, NewX, NewY):-
  iaMove(IAPlayer, Color, X, Y, NewX, NewY).

userMove(X,Y,NewX,NewY):-
  getUserMove(X,Y,NewX,NewY),
  (checkEat(X, Y, _, _, NewX, NewY);checkMove(X, Y, NewX, NewY)).
userMove(X,Y,NewX,NewY):-
  nl,write('This move is impossible, please, try another one:'),nl,nl,
  userMove(X,Y,NewX,NewY).

% Returns the User move
getUserMove(X,Y,NewX,NewY):-
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
