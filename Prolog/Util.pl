/*Converte de inteiro para float */
convertToFloat(ValorInteiro,ValorFloat):-
    ValorFloat is float(ValorInteiro).

/*Retorna o angulo em graus a partir de um vetor (x, y)
Ajusta o angulo baseado nos quadrantes do X*/
getAngle(Tuple,Angle):-
    Tuple = (X,Y),
    Resp is 0,
    ((X,_) -> Angle is 0; Angle is -((atan(Y,X) * 180/pi) + adjust(Tuple,Resp))).

/*Ajusta o angulo baseado nos quadrantes do X*/
adjust(Angle,NewAngle):-
    (Angle == 0 -> NewAngle is 0);
    (Angle < 0 -> NewAngle is 90; NewAngle is 270).

/*Retorna uma bolha aleatoria*/
randomBubble(Float1,Float2,Int,Bubble)
    (Float1,Float2,Int) = Bubble {
        BubblePos = (Float1,Float2),
        BubbleCaractere = randomCaracteres(Int)
    }.

/*Retorna uma caractere aleatorio*/
randomCaracteres(Inteiro,Caractere):- 
    carac = rem (randomNumber(1.5)*z) 5
    (carac is 1 -> Caractere = '$');
    (carac is 2 -> Caractere = '#');
    (carac is 3 -> Caractere = '*');
    (carac is 4 -> Caractere = '@'; Caractere = '%').

/*Retorna um numero aleatorio*/
randomNumber(Tupla,NumeroAleatorio):-
    Tupla = (X,Y),
    NumeroAleatorio = unsafePerformIO(randomRIO (a,b)). //rever essa linha

/*Retorna um novo atirador*/
newShoot(Float,Shoot):-
    Shoot = {
        BubbleShoot = randomBubble(0,-260,round(T)),
        ShootVel = (0,0).
    }.
/*Retorna o atirador inicial*/
getInitialShooter(Shooter):-
    Shooter = {
        ShooterPos   = (0, -300)
        , ShooterAngle = (0, 0)
        , OnShoot      = False
        , NextShoot    = NewShoot
    }.

/*Retorna o mapa de bolhas*/
getMapBubbles(MapBubbles):-
    MapBubbles = (generateMatrix (-320) 370 3 0) ++ getEndBubbles('').

/*Retorna duas linhas de bolhas pretas para indicar o fim*/
getEndBubbles(LinesBubbles):-
    LinesBubbles = (generateEndLine (-320) 410) ++ (generateEndLine((-320),450)).

generateEndLine(X,Y,[Linha]):-
    generateEndLine((X + 40), Y,Line),
    B is Bubble({bubblePos = (x, y), bubbleColor = black}), /* Rever !!*/
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


right(114).
right(67).

left(97).
left(68).

shoot(32).

start(13).

initialShooter([350, -350, 90]).

initialBubbles([]).

checkGameOver([], menu).
checkGameOver(_, game).

rotate(_, _, _).
