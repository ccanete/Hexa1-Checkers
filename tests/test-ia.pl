/*************************************
	         	TEST RANDOM IA
*************************************/

testRandomIA:-
  initBoard,
  printBoard,
  %% test randomIA
  write('--- Test random IA ---'),nl,
  iaMove(randomIA, white, X, Y, Xdest, Ydest),
  write('--- X ---'),write(X),nl,
  write('--- Y ---'),write(Y),nl,
  write('--- Xdest ---'),write(Xdest),nl,
  write('--- Ydest ---'),write(Ydest),nl.


/*************************************
         TEST IA LEVEL UNO
*************************************/

testLevelUno:-
  initBoard,
  printBoard,
  %% test randomIA
  write('--- Test IA level uno ---'),nl,
  write('Move black, 1, 7, 2, 6'),nl,
  processTurn(black, 1, 7, 2, 6),
  printBoard,
  write('Move black, 3, 7, 4, 6'),nl,
  processTurn(black, 3, 7, 4, 6),
  printBoard,
  write('Move black, 5, 7, 6, 6'),nl,
  processTurn(black, 5, 7, 6, 6),
  write('Move white, 2, 4, 1, 5'),nl,
  processTurn(white, 2, 4, 1, 5),
  printBoard,
  iaMove(level1, black, X, Y, Xdest, Ydest),
  printBoard,
  write('--- X ---'),write(X),nl,
  write('--- Y ---'),write(Y),nl,
  write('--- Xdest ---'),write(Xdest),nl,
  write('--- Ydest ---'),write(Ydest),nl.