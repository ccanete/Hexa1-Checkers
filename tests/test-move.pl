testCheckMove:-
  setState(board),
  initBoard,
  printBoard,
  %% test eat and move
  write('--- Test CheckMove ---'),nl,
  write('Test 1: White (2,4) to (3,5) - Valid'),nl,
  checkMove(2, 4, 3, 5),
  write('OK'),nl,
  write('Test 2: White (2,4) to (1,5) - Valid'),nl,
  checkMove(2, 4, 1, 5),
  write('OK'),nl,
  write('Test 3: White (3,7) to (4,6) - Valid'),nl,
  checkMove(3, 7, 4, 6),
  write('OK'),nl,
  write('Test 4: White (3,7) to (2,6) - Valid'),nl,
  checkMove(3, 7, 2, 6),
  write('OK'),nl,
  write('Test 5: White (1,7) to (0,6) - Error destination out of limit'),nl,
  not(checkMove(1, 7, 0, 6)),
  write('OK'),nl,
  write('Test 6: No pawn (2,7) to (3,6) - Error no pawn selected'),nl,
  not(checkMove(2, 7, 3, 6)),
  write('OK'),nl,
  write('Test 7: White (1,7) to (2,7) - Move not allowed'),nl,
  not(checkMove(1, 7, 2, 7)),
  write('OK'),nl,
  write('Test 8: White (1,7) to (1,8) - Move not allowed'),nl,
  not(checkMove(1, 7, 1, 8)),
  write('OK'),nl,
  write('Test 9: White (8,2) to (7,4) - destination not empty'),nl,
  not(checkMove(8, 2, 7, 4)),
  write('OK'),nl,
  write('--- Test Move Completed ---'),nl.

/***************************
      TEST MOVE QUEEN
***************************/

testCheckMoveQueen :-
  setState(board),
  initBoard,
  %% Prepare board for tests
  processTurn(white, 2, 4, 3, 5),
  processTurn(white, 4, 4, 5, 5),
  processTurn(white, 3, 5, 2, 6),
  processTurn(white, 5, 5, 4, 6),

  processTurn(black, 1, 7, 3, 5),
  processTurn(black, 3, 7, 5, 5),
  
  processTurn(white, 1, 3, 2, 4),
  processTurn(black, 3, 5, 1, 3),
  processTurn(white, 3, 3, 2, 4),
  processTurn(white, 4, 2, 3, 3),
  processTurn(white, 3, 1, 4, 2),
  processTurn(black, 1, 3, 3, 1), % black queen

  processTurn(white, 2, 4, 1, 5),
  processTurn(white, 3, 3, 2, 4),
  processTurn(white, 4, 2, 3, 3),
  processTurn(white, 5, 3, 4, 4),
  processTurn(white, 6, 4, 4, 6),
  printBoard,
  % Board ready for queen moves tests
  checkMove(3, 1, 2, 2),
  write('OK'),nl,
  processTurn(black, 3, 1, 4, 2),
  processTurn(black, 4, 2, 5, 3),
  processTurn(black, 5, 3, 3, 5),
  processTurn(black, 3, 5, 2, 6),
  processTurn(black, 2, 6, 1, 7),
  checkMove(1, 7, 5, 3),
  write('OK'),nl,
  printBoard,
  processTurn(black,1, 7, 5, 3),
  printBoard,

  processTurn(white, 3, 3, 4, 4),
  processTurn(white, 1, 5, 2, 6),
  processTurn(black,5, 7, 4, 6),

  printBoard.
