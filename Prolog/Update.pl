:-style_check(-discontiguous).
:-style_check(-singleton).

updateShooter(Bubbles, Shooter, FallenBubbles, false, Bubbles, Shooter, FallenBubbles, false).

updateShooter(Bubbles, [Pos, Shoot], FallenBubbles, true, NewBubbles, [Pos, FinalShoot], NewFallenBubbles, NewOnShoot):-

    updateShoot(Shoot, NewShoot),

    collision(Bubbles, NewShoot, FallenBubbles, NewBubbles, FinalShoot, NewFallenBubbles, NewOnShoot).

updateShoot([[A, B], Color], [[A, NewB], Color]):-
    distanciaVertical(Dis),

    NewB is B - Dis.

collision(Bubbles, Shoot, FallenBubbles, NewBubbles, NewShoot, NewFallenBubbles, NewOnShoot):-

    collided(Bubbles, Shoot, Collided),

    (
        Collided = true -> handleCollision(Bubbles, Shoot, FallenBubbles, NewBubbles, NewShoot, NewFallenBubbles, NewOnShoot);
        
        NewBubbles = Bubbles,
        NewShoot = Shoot,
        NewFallenBubbles = FallenBubbles,
        NewOnShoot = true
    ).

collided([], _, false).

collided([[[C, D], _]|Tail], [[A, B], Color], Collided) :-

    (
        isHit([A, B], [C, D]) -> Collided = true;
        collided(Tail, [[A, B], Color], Collided)
    ).

handleCollision(Bubbles, Shoot, FallenBubbles, FinalBubbles, NewShoot, NewFallenBubbles, false):-
    adjacentSameColor(Bubbles, Shoot, AdjacentList),
    remove_list(Bubbles, AdjacentList, NewBubbles),

    juntas(NewBubbles, Shoot, AdjacentList, DeleteBubbles),

    size(DeleteBubbles, Size),

    (
        Size < 3 -> append(Bubbles, [Shoot], FinalBubbles), NewFallenBubbles = FallenBubbles;
        remove_list(Bubbles, DeleteBubbles, NewBubbles2),
        removeFallenBubbles(NewBubbles2, FallenBubbles, FinalBubbles, NewFallenBubbles)
    ),

    random(0, 3, Flag),
    initialShoot(NewShoot, Flag).

juntas(_, Bubble, [], [Bubble]).
juntas(Bubbles, Bubble, [Head|Tail], DeleteBubbles) :-
    % Head's adjacent list 
    adjacentSameColor(Bubbles, Head, AdjacentList),

    % Remove head's adjacent list from bubbles' list
    remove_list(Bubbles, AdjacentList, NewBubbles),

    % Get destroyed bubbles by head
    juntas(NewBubbles, Head, AdjacentList, NewDeleteBubbles1),

    % Remove destroyed bubbles by head
    remove_list(NewBubbles, NewDeleteBubbles1, NewBubbles2),

    % Continue to get destroyed bubbles from current bubble's adjacent list
    juntas(NewBubbles2, Bubble, Tail, NewDeleteBubbles2),

    % Merge destroyed bubbles from head and the rest of current adjacent bubble
    union(NewDeleteBubbles1, NewDeleteBubbles2, DeleteBubbles).

removeFallenBubbles(Bubbles, FallenBubbles, NewBubbles, FinalFallenBubbles) :-
    fallenBubbles(Bubbles, NewFallenBubbles),

    remove_list(Bubbles, NewFallenBubbles, NewBubbles),

    append(FallenBubbles, NewFallenBubbles, FinalFallenBubbles).

fallenBubbles([], []).
fallenBubbles([Head|Tail], FallenBubbles):-
    adjacent(Tail, Head, AdjacentList),

    remove_list(Tail, AdjacentList, NewBubbles),

    connected(NewBubbles, Head, AdjacentList, Graph),

    (
        member([[_, 1], _], Graph) -> NewFallenBubbles = [];
        NewFallenBubbles = Graph
    ),

    remove_list(NewBubbles, Graph, NewBubbles2),

    fallenBubbles(NewBubbles2, NewFallenBubbles2),

    append(NewFallenBubbles, NewFallenBubbles2, FallenBubbles).

connected(_, Bubble, [], [Bubble]).
connected(Bubbles, Bubble, [Head|Tail], ConnectedBubbles) :-
    % Head's adjacent list 
    adjacent(Bubbles, Head, AdjacentList),

    % Remove head's adjacent list from bubbles' list
    remove_list(Bubbles, AdjacentList, NewBubbles),

    % Get connected bubbles from head
    connected(NewBubbles, Head, AdjacentList, NewConnectedBubbles1),

    % Remove connected bubbles from head
    remove_list(NewBubbles, NewConnectedBubbles1, NewBubbles2),

    % Continue to get connected bubbles from current bubble's adjacent list
    connected(NewBubbles2, Bubble, Tail, NewConnectedBubbles2),

    % Merge connected bubbles from head and the rest of current bubble
    union(NewConnectedBubbles1, NewConnectedBubbles2, ConnectedBubbles).

updateFallenBubbles([], []).
updateFallenBubbles([[[A, B], Color]|Tail], NewFallenBubbles):-
    distanciaVertical(Dis),
    BB is B + Dis,

    (
        BB > 30 -> Add = [];
        Add = [[[A, BB], Color]]
    ),

    updateFallenBubbles(Tail, FallenBubbles),

    append(Add, FallenBubbles, NewFallenBubbles).