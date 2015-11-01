/*************************************
		TEST RANDOM IA
*************************************/

testRandomIA:-
  initBoard,
  printBoard,
  %% test randomIA
  write('--- Test random IA ---'),nl,
  randomIA(white, X, Y, Xdest, Ydest),
  write('--- X ---'),write(X),nl,
  write('--- Y ---'),write(Y),nl,
  write('--- Xdest ---'),write(Xdest),nl,
  write('--- Ydest ---'),write(Ydest),nl.