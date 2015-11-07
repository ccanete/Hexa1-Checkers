
# Hexa1-Checkers
Checkers game in prolog
===============

A Checkers game with multiple AIs

Installation
------------

Install a recent distribution of [SWI Prolog](http://www.swi-prolog.org/).

Clone this repo:

```shell
git clone https://github.com/HexanomeBeurreOne/Hexa1-Checkers.git
cd Hexa1-Checkers
```

Usage
-----

### Run the game

Open SWI and call the main file  
```prolog
?- ['///main.pl'].
```
Then run
```prolog
?- playCheckers().
```
And follow instructions

### Run the tests

Open SWI and call the tests file  
```prolog
?- ['///tests.pl'].
```

And run one of the test :
```prolog
?- testDoEat().
?- testCheckMove().
?- testCheckMoveQueen().
?- testGetPiece().
?- testRandomIA().
?- testLevelUno().
?- testMinimaxIA().
```
