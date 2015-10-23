
# Hexa1-Checkers
Checkers game in prolog

%%%%%%%%%%%%%%%%%%%%%%% Prolog checkEat

Pour vérifier la possiblité de manger une pièce, j'ai divisé la fonction principale en plusiers conditions: 

- que la position soit correcte (opposés et jouable) par rapport au type de pièces (validePlayerPosition)
- quelle est la portée de la pièce, selon s il s.agit d'une reine ou un pawn
- on évalue avec ses paramètres-là que la pièce qu'on essaie de manger se trouve bien sur une des diagonales de la pièce à jouer et que elle est à sa portée; de meme, on vérifie, notamment pour le cas de la reine que toutes les cases en tre ces 2 pièces sont vides
- finalement, que la position d'arrivée, après avoir mangé la pièce sera vide aussi 

>>>> Fonctional examples: 

>> For doEat

doEat([wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,wp,nl,wp,nl,em,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,em,nl,em,nl,em,nl,em,nl,em,nl,nl,em,nl,em,nl,em,nl,em,nl,em,bq,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp], PosX, PosY, NewPosX, NewPosY, NewBoard).

Result ; 

X = 1,
Y = 7,
XEater = 5,
YEater = 3,
NewBoard = [wp, nl, wp, nl, wp, nl, wp, nl, wp|...] 

>> For checkEat

Case Queen can eat:
checkEat([wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,wp,nl,wp,nl,em,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,em,nl,em,nl,em,nl,em,nl,em,nl,nl,em,nl,em,nl,em,nl,em,nl,em,bq,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp], 60, 33, NextCase).

Case Queen cannot eat (piece in between):
checkEat([wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,wp,nl,wp,nl,em,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,em,nl,wp,nl,em,nl,em,nl,em,nl,nl,em,nl,em,nl,em,nl,em,nl,em,bq,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp], 60, 33, NextCase).

Case Queen cannot eat (no free case to land after eating):
checkEat([wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,wp,nl,wp,nl,wp,nl,wp,nl,wp,nl,nl,wp,nl,wp,nl,wp,nl,wp,nl,wp,em,nl,em,nl,em,nl,em,nl,em,nl,nl,em,nl,em,nl,em,nl,em,nl,em,bq,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp,bp,nl,bp,nl,bp,nl,bp,nl,bp,nl,nl,bp,nl,bp,nl,bp,nl,bp,nl,bp], 60, 33, NextCase).