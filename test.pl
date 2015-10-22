%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Test for Checkers game        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* Module Imports */
?- ['actions/queen.pl'].
?- ['actions/eat.pl'].
?- ['actions/move.pl'].
?- ['actions/checkEat.pl'].
?- ['helpers/drawBoard.pl'].
?- ['helpers/util.pl'].

initBoard(Board) :-
      Board = [11,21,31,nl,wp,nl,wp,nl,wp,nl,
      				 12,22,32,wp,nl,wp,nl,wp,nl,wp,
      				 13,23,33,nl,wp,nl,wp,nl,wp,nl,
      				 14,24,34,wp,nl,wp,nl,wp,nl,wp,
      				 em,nl,em,nl,em,nl,em,nl,em,nl,
      				 nl,em,nl,em,nl,em,nl,em,nl,em,
      				 bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
      				 nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,
      				 bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,
      				 nl,bp,nl,bp,nl,bp,nl,bp,nl,bp].

testGetPiece:-
  initBoard(Board),
  printBoard(Board),
  write('--- Test getPiece ---'),nl,
  write('Test 1: X=1, Y=1'),nl,
  getPiece(Board, 1, 1, Piece1),
  write('piece : '),
  write(Piece1),nl,
  Piece1 == 11,
  write('Test 2: X=2, Y=3'),nl,
  getPiece(Board, 2, 3, Piece2),
  write('piece : '),
  write(Piece2),nl,
  Piece2 == 23,
  write('Test 3: X=3, Y=2'),nl,
  getPiece(Board, 3, 2, Piece3),
  write('piece : '),
  write(Piece3),nl,
  Piece3 == 32.

testMove:-
  initBoard(Board),
  printBoard(Board),
  %% test eat and move
  write('--- Test Move ---'),nl,
  write('Test 1: valid move white pown 1'),nl,
  checkMove(Board, 2, 4, 1, 5, white),
  write('OK'),nl,
  write('Test 2: valid move white pown 2'),nl,
  checkMove(Board, 2, 4, 3, 5, white),
  write('OK'),nl,
  write('Test 3: valid move black pown 1'),nl,
  checkMove(Board, 3, 7, 4, 6, black),
  write('OK'),nl,
  write('Test 4: valid move black pown 2'),nl,
  checkMove(Board, 3, 7, 2, 6, black),
  write('OK'),nl.
