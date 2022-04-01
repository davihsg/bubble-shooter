:-style_check(-discontiguous).
:-style_check(-singleton).

updateShooter(Bubbles, Shooter, false, Bubbles, Shooter, false).

updateShooter(Bubbles, [Pos, Shoot], true, NewBubbles, [Pos, FinalShoot], NewOnShoot):-

    updateShoot(Shoot, NewShoot),

    collision(Bubbles, NewShoot, NewBubbles, FinalShoot, NewOnShoot).

updateShoot([[A, B], Color], [[A, NewB], Color]):-
    distanciaVertical(Dis),

    NewB is B - Dis.

collision(Bubbles, Shoot, NewBubbles, NewShoot, NewOnShoot):-

    collided(Bubbles, Shoot, Collided),

    (
        Collided = true -> handleCollision(Bubbles, Shoot, NewBubbles, NewShoot, NewOnShoot);
        
        NewBubbles = Bubbles,
        NewShoot = Shoot,
        NewOnShoot = true
    ).

collided([], _, false).

collided([[[C, D], _]|Tail], [[A, B], Color], Collided) :-

    (
        isHit([A, B], [C, D]) -> Collided = true;
        collided(Tail, [[A, B], Color], Collided)
    ).

handleCollision(Bubbles, Shoot, FinalBubbles, NewShoot, false):-
    adjacentSameColor(Bubbles, Shoot, AdjacentList),
    remove_list(Bubbles, AdjacentList, NewBubbles),

    juntas(NewBubbles, Shoot, AdjacentList, DeleteBubbles),

    size(DeleteBubbles, Size),

    (
        Size < 3 -> append(Bubbles, [Shoot], FinalBubbles);
        remove_list(Bubbles, DeleteBubbles, FinalBubbles)
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