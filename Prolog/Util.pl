rightKey(114).
rightKey(67).

leftKey(97).
leftKey(68).

shootKey(32).

startKey(13).

initialShooter([350, -350, 90]).

initialBubbles([]).

checkGameOver([], menu).
checkGameOver(_, game).

rotateLeft(Shooter, Shooter).
rotateRight(Shooter, Shooter).

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


print_matrix(Matrix) :-
    matrix_to_str(Matrix, Str),
    write(Str).

matrix_to_str([], "").

matrix_to_str([Head | Tail], Str) :-
    matrix_to_str(Tail, NextStr),
    string_concat(Head, NextStr, Str).

print_menu():-                                                                                                                           
    L1 = "Commands: A, D, SPACE",
    L2 = "Press Enter to start the game",
    L3 = "########",
    L4 = "########",


    List = [L1, L2, L3, L4],
    
    nl, nl, nl, nl,
    print_L(List, 0).
    
print_L([], _).

print_L([Head|Tail], 0) :-
    write("                                             "),
    write(Head),
    nl,
    nl,
    Ncount is 1,
    print_L(Tail, Ncount).


print_L([Head|Tail], 1) :-
    write("                                         "),
    write(Head),
    nl,
    nl,
    Ncount is 2,
    print_L(Tail, Ncount).


print_L([Head|Tail], 2) :-
    write("                                                    "),
    write(Head),
    nl,
    nl,
    Ncount is 2,
    print_L(Tail, Ncount).


