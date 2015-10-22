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
  write('Test 1: White (2,4) to (3,5) - Valid'),nl,
  checkMove(Board, 2, 4, 3, 5),
  write('OK'),nl,
  write('Test 2: White (2,4) to (5,5) - Valid'),nl,
  checkMove(Board, 2, 4, 1, 5),
  write('OK'),nl,
  write('Test 3: White (2,4) to (3,5) - Valid'),nl,
  checkMove(Board, 3, 7, 4, 6),
  write('OK'),nl,
  write('Test 4: White (2,4) to (3,5) - Valid'),nl,
  checkMove(Board, 3, 7, 2, 6),
  write('OK'),nl,
  write('Test 5: White (1,7) to (0,6) - Error destination out of limit'),nl,
  not(checkMove(Board,1, 7, 0, 6)),
  write('OK'),nl,
  write('Test 6: No pawn (2,7) to (3,6) - Error no pawn selected'),nl,
  not(checkMove(Board,2, 7, 3, 6)),
  write('OK'),nl,
  write('Test 7: White (1,7) to (2,7) - Move not allowed'),nl,
  not(checkMove(Board,1, 7, 2, 7)),
  write('OK'),nl,
  write('Test 8: White (1,7) to (1,8) - Move not allowed'),nl,
  not(checkMove(Board,1, 7, 1, 8)),
  write('OK'),nl,
  write('Test 9: White (8,2) to (7,4) - destination not empty'),nl,
  not(checkMove(Board,8, 2, 7, 4)),
  write('OK'),nl,
  write('--- Test Move Completed ---'),nl.
