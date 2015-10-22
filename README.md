# Hexa1-Checkers
Checkers game in prolog

To test checkEat use this command : 

checkEat([wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,wp,nl,wp,nl,em,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,em,nl,em,nl,em,nl,em,nl,em,nl,nl,em,nl,em,nl,em,nl,em,nl,em,bq,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp], Pos1, Pos2, NewPos).

Example of Board -> true result (the only possible case) : Pos1 : 60(bq), Pos2: 33(wp); NewPos: 24(bq);

Example of doEat -> doEat([wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,wp,nl,wp,nl,em,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,em,nl,em,n,em,nl,em,nl,em,nl,nl,em,nl,em,nl,em,nl,em,nl,em,bq,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp], X, Y, XNewPos, YNewPos, NewBoard).

Result ; 

X = 1,
Y = 7,
XEater = 5,
YEater = 3,
NewBoard = [wp, nl, wp, nl, wp, nl, wp, nl, wp|...] 


