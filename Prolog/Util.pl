rightKey(100).
rightKey(67).

leftKey(97).
leftKey(68).

shootKey(32).

startKey(13).
startKey(10).

initialShooter([[350, -350], Bubble]) :-
    initialShoot(Bubble).

initialShoot([[350, -350], #]).

initialBubbles([[362, -320], #]).

leftLimit(0).

rightLimit(600).

checkGameOver([], menu).
checkGameOver(_, game).

moveLeft([[X, Y], Shoot], [[NewX, Y], Shoot]):-
    distancia(Dis),

    (
        leftLimit(X) -> NewX is X;
        NewX is X - Dis
    ).

moveRight([[X, Y], Shoot], [[NewX, Y], Shoot]):-
    distancia(Dis),

    (
        rightLimit(X) -> NewX is X;
        NewX is X + Dis
    ).

distancia(3).

isHit([A, B], [C, D]) :-
    distancia(Dis),

    abs(A - C, DeltaX),
    abs(B - D, DeltaY),

    DeltaX + DeltaY =< Dis * 2.

size([], 0).

size([X|Tail], Size):-

    size(Tail, NewSize),

    Size is NewSize + 1.

/*
convertToFloat(ValorInteiro,ValorFloat):-
    ValorFloat is float(ValorInteiro).

getAngle(Tuple,Angle):-
    Tuple = (X,Y),
    Resp is 0,
    ((X,_) -> Angle is 0; Angle is -((atan(Y,X) * 180/pi) + adjust(Tuple,Resp))).

adjust(Angle,NewAngle):-
    (Angle == 0 -> NewAngle is 0);
    (Angle < 0 -> NewAngle is 90; NewAngle is 270).

randomBubble(Float1,Float2,Int,Bubble)
    (Float1,Float2,Int) = Bubble {
        BubblePos = (Float1,Float2),
        BubbleCaractere = randomCaracteres(Int)
    }.

randomCaracteres(Inteiro,Caractere):- 
    carac = rem (randomNumber(1.5)*z) 5
    (carac is 1 -> Caractere = '$');
    (carac is 2 -> Caractere = '#');
    (carac is 3 -> Caractere = '*');
    (carac is 4 -> Caractere = '@'; Caractere = '%').

randomNumber(Tupla,NumeroAleatorio):-
    Tupla = (X,Y),
    NumeroAleatorio = unsafePerformIO(randomRIO (a,b)). //rever essa linha

newShoot(Float,Shoot):-
    Shoot = {
        BubbleShoot = randomBubble(0,-260,round(T)),
        ShootVel = (0,0).
    }.

getInitialShooter(Shooter):-
    Shooter = {
        ShooterPos   = (0, -300)
        , ShooterAngle = (0, 0)
        , OnShoot      = False
        , NextShoot    = NewShoot
    }.

getMapBubbles(MapBubbles):-
    MapBubbles = (generateMatrix (-320) 370 3 0) ++ getEndBubbles('').

getEndBubbles(LinesBubbles):-
    LinesBubbles = (generateEndLine (-320) 410) ++ (generateEndLine((-320),450)).

generateEndLine(X,Y,[Linha]):-
    generateEndLine((X + 40), Y,Line),
    B is Bubble({bubblePos = (x, y), bubbleColor = black}),
    concat([B],Line,List)
    (x > 320 -> [Linha] is []; Linha -> Line )

generateMatrix(X,Y,Z,T,[Matrix]):-
    generateLine(X+(15 * T),Y,(Z+7),S1),
    generateMatrix(X,(Y-40),(Z+7),T,S2),
    generateLine(X+(15 * T),Y,Z,S3),
    concat(S1,S2,Atom),
    (y =< 120 -> [Matrix] is S3 ; [Matrix] is Atom).


generateLine(X,Y,Z,[Matrix]):-
    randomBubble(X,Y,Z,Rb),
    generateLine((X + 40), Y,(Z+7),Gl),
    concat(Rb,Gl,Line),
    (X > 120 -> [Matrix] is []; [Matrix] is Line).


getVel((X,Y),Tuple):-
    K is sqrt((X*X) + (Y * Y)),
    Tuple is (X/K, Y/K).
*/
