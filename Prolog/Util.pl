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

initialBubbless([[362, -320], #]).

leftLimit(0).

rightLimit(600).

% initialBubbles('
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% | H || O || X || X || H || O || O || X || X || O || O || H || X || H || X || X || H || O || X |
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% | X || H || O || X || X || O || O || H || X || X || H || O || O || H || H || X || H || H || X |
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% | H || O || H || O || H || X || H || X || X || H || H || O || H || X || X || O || H || O || H |
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% | X || O || H || X || X || X || H || O || H || H || O || H || O || H || H || X || H || O || X |
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% | X || O || O || X || H || O || H || X || O || X || X || H || X || X || X || X || H || O || O | 
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|
% | H || O || H || X || H || X || H || X || X || X || O || X || X || O || O || H || O || O || O | 
% |---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---||---|').
initialBubbles([[[2, 1], 'H'], [[7, 1], 'O'], [[12, 1], 'X'], [[17, 1], 'X'], [[22, 1], 'H'], [[27, 1], 'O'], [[32, 1], 'O'], [[37, 1], 'X'], [[42, 1], 'X'], [[47, 1], 'O'], [[52, 1], 'O'], [[57, 1], 'H'], [[62, 1], 'X'], [[67, 1], 'H'], [[72, 1], 'X'], [[77, 1], 'X'], [[82, 1], 'H'], [[87, 1], 'O'], [[92, 1], 'X'], [[2, 4], 'X'], [[7, 4], 'H'], [[12, 4], 'O'], [[17, 4], 'X'], [[22, 4], 'X'], [[27, 4], 'O'], [[32, 4], 'O'], [[37, 4], 'H'], [[42, 4], 'X'], [[47, 4], 'X'], [[52, 4], 'H'], [[57, 4], 'O'], [[62, 4], 'O'], [[67, 4], 'H'], [[72, 4], 'H'], [[77, 4], 'X'], [[82, 4], 'H'], [[87, 4], 'H'], [[92, 4], 'X'], [[2, 7], 'H'], [[7, 7], 'O'], [[12, 7], 'H'], [[17, 7], 'O'], [[22, 7], 'H'], [[27, 7], 'X'], [[32, 7], 'H'], [[37, 7], 'X'], [[42, 7], 'X'], [[47, 7], 'H'], [[52, 7], 'H'], [[57, 7], 'O'], [[62, 7], 'H'], [[67, 7], 'X'], [[72, 7], 'X'], [[77, 7], 'O'], [[82, 7], 'H'], [[87, 7], 'O'], [[92, 7], 'H'], [[2, 10], 'X'], [[7, 10], 'O'], [[12, 10], 'H'], [[17, 10], 'X'], [[22, 10], 'X'], [[27, 10], 'X'], [[32, 10], 'H'], [[37, 10], 'O'], [[42, 10], 'H'], [[47, 10], 'H'], [[52, 10], 'O'], [[57, 10], 'H'], [[62, 10], 'O'], [[67, 10], 'H'], [[72, 10], 'H'], [[77, 10], 'X'], [[82, 10], 'H'], [[87, 10], 'O'], [[92, 10], 'X'], [[2, 13], 'X'], [[7, 13], 'O'], [[12, 13], 'O'], [[17, 13], 'X'], [[22, 13], 'H'], [[27, 13], 'O'], [[32, 13], 'H'], [[37, 13], 'X'], [[42, 13], 'O'], [[47, 13], 'X'], [[52, 13], 'X'], [[57, 13], 'H'], [[62, 13], 'X'], [[67, 13], 'X'], [[72, 13], 'X'], [[77, 13], 'X'], [[82, 13], 'H'], [[87, 13], 'O'], [[92, 13], 'O'], [[2, 16], 'H'], [[7, 16], 'O'], [[12, 16], 'H'], [[17, 16], 'X'], [[22, 16], 'H'], [[27, 16], 'X'], [[32, 16], 'H'], [[37, 16], 'X'], [[42, 16], 'X'], [[47, 16], 'X'], [[52, 16], 'O'], [[57, 16], 'X'], [[62, 16], 'X'], [[67, 16], 'O'], [[72, 16], 'O'], [[77, 16], 'H'], [[82, 16], 'O'], [[87, 16], 'O'], [[92, 16], 'O']]
).

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

print_matrix(Matrix) :-
    matrix_to_str(Matrix, Str),
    write(Str).

matrix_to_str([], "").

matrix_to_str([Head | Tail], Str) :-
    matrix_to_str(Tail, NextStr),
    string_concat(Head, NextStr, Str).

print_menu():-                                                                                                                           
    L1 = "Commands: A, D, SPACE               |",
    L2 = "Press Enter to start the game           |",
    L3 = "Bubble                       |",
    L4 = "Shooter                      |",
    L0 = "------------------------------------------------------------------------------------------------",
    L6 = "------------------------------------------(⌐▨_▨ )-----------------------------------------------",

    List = [L1, L2, L3, L4],
    
    nl, nl, nl, nl,
    write(L0), nl,
    print_L(List, 0),
    write(L6), nl, nl.
print_L([], _).

print_L([Head|Tail], 0) :-
    write("                   |               "),
    write(Head),
    nl,
    nl,
    Ncount is 1,
    print_L(Tail, Ncount).


print_L([Head|Tail], 1) :-
    write("                   |           "),
    write(Head),
    nl,
    nl,
    Ncount is 2,
    print_L(Tail, Ncount).


print_L([Head|Tail], 2) :-
    write("                   |                      "),
    write(Head),
    nl,
    nl,
    Ncount is 2,
    print_L(Tail, Ncount).


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
