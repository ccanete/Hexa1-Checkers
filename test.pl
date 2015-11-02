%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Test for Checkers game        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* Module Imports */
?- ['main.pl'].

?- ['actions/queen.pl'].
?- ['actions/eat.pl'].
?- ['actions/move.pl'].

?- ['helpers/drawBoard.pl'].
?- ['helpers/util.pl'].
?- ['helpers/pieceFacts.pl'].
?- ['helpers/rules.pl'].
?- ['helpers/turn.pl'].

?- ['ia/helpersIA.pl'].
?- ['ia/randomIA.pl'].
?- ['ia/worthToMove.pl'].
?- ['ia/IALevelUno.pl'].

?- ['tests/test-move.pl'].
?- ['tests/test-util.pl'].
?- ['tests/test-eat.pl'].
?- ['tests/test-ia.pl'].
