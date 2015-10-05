%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prolog game                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The initial board (origin box : lower left corner of the board)
init( Board) :-
      Board = b(wp,n,wp,n,wp,n,wp,n,wp,n,
				n,wp,n,wp,n,wp,n,wp,n,wp,
				wp,n,wp,n,wp,n,wp,n,wp,n,
				n,wp,n,wp,n,wp,n,wp,n,wp,
				e,n,e,n,e,n,e,n,e,n,
				n,e,n,e,n,e,n,e,n,e,
				bp,n,bp,n,bp,n,bp,n,bp,n,
				n,bp,n,bp,n,bp,n,bp,n,bp,
				bp,n,bp,n,bp,n,bp,n,bp,n,
				n,bp,n,bp,n,bp,n,bp,n,bp).

% n : null (unaccessible box)
% e : free box
% bq : black queen
% wq : white queen
% bp : black pawn
% wp : white pawn