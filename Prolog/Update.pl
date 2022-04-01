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

handleCollision(Bubbles, Shoot, NewBubbles, NewShoot, false):-
    juntas(Bubbles, Shoot, MapBubbles),

    size(MapBubbles, Size),

    (
        Size < 3 -> append(Bubbles, [Shoot], NewBubbles);
        deletar(MapBubbles, Bubbles, NewBubbles)
    ),

    initialShoot(NewShoot).

juntas(_, _, []).

deletar(_, Bubbles, Bubbles) :-
    NewBubbles = Bubbles.

updateBubbles(Bubbles, NewBubbles, Time) :-
    NewBubbles = Bubbles.