:- include('Assets.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

rightKey(100).
rightKey(67).

leftKey(97).
leftKey(68).

shootKey(32).

startKey(13).
startKey(10).

initialShooter([[32, 31], Bubble]) :-
    random(0, 3, Flag),
    initialShoot(Bubble, Flag).

initialShoot([[47, 26], 'X'], 0).

initialShoot([[47, 26], 'H'], 1).

initialShoot([[47, 26], 'O'], 2).

leftLimit(2).

rightLimit(97).

initialBubbles([[[2, 1], 'H'], [[7, 1], 'O'], [[12, 1], 'X'], [[17, 1], 'X'], [[22, 1], 'H'], [[27, 1], 'O'], [[32, 1], 'O'], [[37, 1], 'X'], [[42, 1], 'X'], [[47, 1], 'O'], [[52, 1], 'O'], [[57, 1], 'H'], [[62, 1], 'X'], [[67, 1], 'H'], [[72, 1], 'X'], [[77, 1], 'X'], [[82, 1], 'H'], [[87, 1], 'O'], [[92, 1], 'X'], [[2, 4], 'X'], [[7, 4], 'H'], [[12, 4], 'O'], [[17, 4], 'X'], [[22, 4], 'X'], [[27, 4], 'O'], [[32, 4], 'O'], [[37, 4], 'H'], [[42, 4], 'X'], [[47, 4], 'X'], [[52, 4], 'H'], [[57, 4], 'O'], [[62, 4], 'O'], [[67, 4], 'H'], [[72, 4], 'H'], [[77, 4], 'X'], [[82, 4], 'H'], [[87, 4], 'H'], [[92, 4], 'X'], [[2, 7], 'H'], [[7, 7], 'O'], [[12, 7], 'H'], [[17, 7], 'O'], [[22, 7], 'H'], [[27, 7], 'X'], [[32, 7], 'H'], [[37, 7], 'X'], [[42, 7], 'X'], [[47, 7], 'H'], [[52, 7], 'H'], [[57, 7], 'O'], [[62, 7], 'H'], [[67, 7], 'X'], [[72, 7], 'X'], [[77, 7], 'O'], [[82, 7], 'H'], [[87, 7], 'O'], [[92, 7], 'H'], [[2, 10], 'X'], [[7, 10], 'O'], [[12, 10], 'H'], [[17, 10], 'X'], [[22, 10], 'X'], [[27, 10], 'X'], [[32, 10], 'H'], [[37, 10], 'O'], [[42, 10], 'H'], [[47, 10], 'H'], [[52, 10], 'O'], [[57, 10], 'H'], [[62, 10], 'O'], [[67, 10], 'H'], [[72, 10], 'H'], [[77, 10], 'X'], [[82, 10], 'H'], [[87, 10], 'O'], [[92, 10], 'X'], [[2, 13], 'X'], [[7, 13], 'O'], [[12, 13], 'O'], [[17, 13], 'X'], [[22, 13], 'H'], [[27, 13], 'O'], [[32, 13], 'H'], [[37, 13], 'X'], [[42, 13], 'O'], [[47, 13], 'X'], [[52, 13], 'X'], [[57, 13], 'H'], [[62, 13], 'X'], [[67, 13], 'X'], [[72, 13], 'X'], [[77, 13], 'X'], [[82, 13], 'H'], [[87, 13], 'O'], [[92, 13], 'O'], [[2, 16], 'H'], [[7, 16], 'O'], [[12, 16], 'H'], [[17, 16], 'X'], [[22, 16], 'H'], [[27, 16], 'X'], [[32, 16], 'H'], [[37, 16], 'X'], [[42, 16], 'X'], [[47, 16], 'X'], [[52, 16], 'O'], [[57, 16], 'X'], [[62, 16], 'X'], [[67, 16], 'O'], [[72, 16], 'O'], [[77, 16], 'H'], [[82, 16], 'O'], [[87, 16], 'O'], [[92, 16], 'O']]).

print_to_str([]).
print_to_str([Head|Tail]):-
    print_line(Head), nl,
    print_to_str(Tail).

print_line([]).
print_line([Head|Tail]):-
    write(Head), 
    print_line(Tail).
    
renderM([],Mat,Mat).
renderM([Head|Tail], Mat, Ans):-           
            renderBubble(Head, Mat, NewAns),
            renderM(Tail, NewAns, Ans).

renderBubble([[X,Y],Carac], Matrix, Ans14):-
        X1 is X + 1,X2 is X - 1, X3 is X + 2, X4 is X - 2, 
        Y1 is Y + 1,Y2 is Y - 1,
        getMatrix(0, Y, X, Carac, Matrix, Ans),        
        getMatrix(0, Y1, X, '-', Ans, Ans1),
        getMatrix(0, Y2, X, '-', Ans1, Ans2),
        getMatrix(0, Y, X1, ' ', Ans2, Ans3),
        getMatrix(0, Y1, X1, '-', Ans3, Ans4),
        getMatrix(0, Y2, X1, '-', Ans4, Ans5),
        getMatrix(0, Y, X2, ' ', Ans5, Ans6),
        getMatrix(0, Y1, X2, '-', Ans6, Ans7),
        getMatrix(0, Y2, X2, '-', Ans7, Ans8),
        getMatrix(0, Y, X3, '|', Ans8, Ans9),
        getMatrix(0, Y1, X3, '|', Ans9, Ans10),
        getMatrix(0, Y2, X3, '|', Ans10, Ans11),
        getMatrix(0, Y, X4, '|', Ans11, Ans12),
        getMatrix(0, Y1, X4, '|', Ans12, Ans13),
        getMatrix(0, Y2, X4, '|', Ans13, Ans14).

renderShooter([[X, Y], [[A, B], Color]], OnShoot, Matrix, Ans14):-

    X1 is X + 1,X2 is X - 1, X3 is X + 2, X4 is X - 2, 
    Y1 is Y + 1,Y2 is Y - 1,
    (
        OnShoot = true -> getMatrix(0, B, A, Color, Matrix, Ans);
        getMatrix(0, Y, X, Color, Matrix, Ans)
    ),
    getMatrix(0, Y1, X, '-', Ans, Ans1),
    getMatrix(0, Y2, X, '-', Ans1, Ans2),
    getMatrix(0, Y, X1, ' ', Ans2, Ans3),
    getMatrix(0, Y1, X1, '-', Ans3, Ans4),
    getMatrix(0, Y2, X1, '-', Ans4, Ans5),
    getMatrix(0, Y, X2, ' ', Ans5, Ans6),
    getMatrix(0, Y1, X2, '-', Ans6, Ans7),
    getMatrix(0, Y2, X2, '-', Ans7, Ans8),
    getMatrix(0, Y, X3, '|', Ans8, Ans9),
    getMatrix(0, Y1, X3, '|', Ans9, Ans10),
    getMatrix(0, Y2, X3, '|', Ans10, Ans11),
    getMatrix(0, Y, X4, '|', Ans11, Ans12),
    getMatrix(0, Y1, X4, '|', Ans12, Ans13),
    getMatrix(0, Y2, X4, '|', Ans13, Ans14).

renderFB([],Mat,Mat).
renderFB([Head|Tail], Mat, Ans):-           
            renderFallenBubble(Head, Mat, NewAns),
            renderFB(Tail, NewAns, Ans).

renderFallenBubble([[X,Y],Color], Matrix, Ans) :-
    getMatrix(0, Y, X, Color, Matrix, Ans).

getMatrix(_,_,_,_,[],[]).
getMatrix(YY, Y, _, _, Matrix, Matrix):- YY > Y.
getMatrix(YY, Y, X, Carac, [Head|Tail], Matrix):-
    YY =< Y,

    (
        YY =:= Y -> getLine(0,X,Carac, Head, NewLine);
                NewLine = Head
    ), 
    NewYY is YY+1,
    getMatrix(NewYY, Y, X, Carac, Tail, NewMatrix),
    append([NewLine], NewMatrix, Matrix).

getLine(_,_,_,[],[]).
getLine(XX, X, _, Linha, Linha):- XX > X.
getLine(XX, X, Carac, [Head|Tail], Linha):-
        XX =< X,
        NewXX is XX+1,

        getLine(NewXX, X, Carac, Tail, NewLine),
        (
            XX =:= X -> append([Carac], NewLine, Linha);
                        append([Head], NewLine, Linha)
        ).

print_matrix(Matrix) :-
    matrix_to_str(Matrix, Str),
    write(Str).

matrix_to_str([], "").

matrix_to_str([Head | Tail], Str) :-
    matrix_to_str(Tail, NextStr),
    string_concat(Head, NextStr, Str).

remove_list([], _, []).
remove_list([X|Tail], L2, Result):- member(X, L2), !, remove_list(Tail, L2, Result). 
remove_list([X|Tail], L2, [X|Result]):- remove_list(Tail, L2, Result).

adjacentSameColor([], _, []).
adjacentSameColor([[PosB, ColorB]|Tail], [PosA, ColorA], AdjacentList) :-
    (
        isHit(PosA, PosB), ColorA =@= ColorB -> Add = [[PosB, ColorB]];
        Add = []
    ),

    adjacentSameColor(Tail, [PosA, ColorA], NewAdjacentList),

    append(Add, NewAdjacentList, AdjacentList).

adjacent([], _, []).
adjacent([[PosB, ColorB]|Tail], [PosA, ColorA], AdjacentList) :-
    (
        isHit(PosA, PosB) -> Add = [[PosB, ColorB]];
        Add = []
    ),

    adjacent(Tail, [PosA, ColorA], NewAdjacentList),

    append(Add, NewAdjacentList, AdjacentList).

checkGameOver([], menu).
checkGameOver(_, game).

moveLeft([[X, Y], Shoot], [[NewX, Y], Shoot]):-
    distanciaHorizontal(Dis),

    (
        leftLimit(X) -> NewX is X;
        NewX is X - Dis
    ).

moveRight([[X, Y], Shoot], [[NewX, Y], Shoot]):-
    distanciaHorizontal(Dis),

    (
        rightLimit(X) -> NewX is X;
        NewX is X + Dis
    ).

distanciaVertical(3).
distanciaHorizontal(5).

isHit([A, B], [C, D]) :-
    distanciaVertical(DisV),
    distanciaHorizontal(DisH),

    abs(A - C, DeltaX),
    abs(B - D, DeltaY),

    DeltaX =< DisH,
    DeltaY =< DisV,

    abs(DeltaX - DisH, Flag1),
    abs(DeltaY - DisV, Flag2),

    Flag1 + Flag2 > 0.
    % nnotEquals(DeltaX, DisH, DeltaY, DisV).

equals(A, A).

notEquals(A, B):-
    equals(A, B), !,
    fail.

notEquals(A, B).

nnotEquals(A, B, X, Y) :- notEquals(A, B), notEquals(X, Y).

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
    
    nl, nl, nl, nl, nl,nl, nl, nl, nl, nl, nl, nl,
    write(L0), nl,
    print_L(List, 0),
    write(L6), nl, nl, nl, nl, nl, nl,nl, nl, nl, nl, nl, nl, nl.

print_L([], _).

print_L([Head|Tail], 0) :-
    write("                       |               "),
    write(Head),
    nl,
    nl,
    Ncount is 1,
    print_L(Tail, Ncount).


print_L([Head|Tail], 1) :-
    write("                       |           "),
    write(Head),
    nl,
    nl,
    Ncount is 2,
    print_L(Tail, Ncount).


print_L([Head|Tail], 2) :-
    write("                       |                      "),
    write(Head),
    nl,
    nl,
    Ncount is 2,
    print_L(Tail, Ncount).
