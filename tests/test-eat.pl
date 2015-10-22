testDoEat:-
  initBoard(Board),
  printBoard(Board),
  %% test eat 
  write('--- Test doEat ---'),nl,
  write('White (2,4) to (3,5) - '),nl,
  write('White (3,5) to (4,6) - '),nl,
  write('Black in (5,7) eats white in (4,6) - Valid'),nl,
  doMove(Board, 2, 4, 3, 5, Board1),
  doMove(Board1, 3, 5, 4, 6, Board2),
  doEat(Board2, 5, 7, 3, 5, Board3),
  processMove(Board3, 5, 7, 3, 5, Board4),
  printBoard(Board4),
  write('OK'),nl,
 
  write('--- Test doEat Completed ---'),nl.
