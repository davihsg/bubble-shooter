updateShooter(Bubbles, Shooter, false, Bubbles, Shooter, false).

updateShooter(Bubbles, [Pos, Shoot], true, NewBubbles, [Pos, NewShoot], NewOnShoot):-
    updateShoot(true, Shoot, NewShoot),

    write("New shoot "), write(NewShoot), nl,

    NewBubbles = Bubbles, 
    NewOnShoot = true.

    %collision(Bubbles, NewShoot, OnShoot, NewBubbles, FinalShoot, NewOnShoot).

updateShoot(true, [[A, B], Color], [[A, NewB], Color]):-
    distancia(Dis),

    NewB is B + Dis.

updateShoot(false, Shoot, Shoot).

collision(Bubbles, Shoot, false, Bubbles, Shoot, false).

collision(Bubbles, Shoot, true, NewBubbles, NewShoot, NewOnShoot,):-

    collided(Bubbles, Shoot, Collided),

    (
        Collided = false -> handleCollision(Bubbles, Shoot, NewBubbles, NewShoot, NewOnShoot);
        
        NewBubbles = Bubbles,
        NewShoot = Shoot,
        NewOnShoot = OnShoot
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

deletar([], _, NewBubbles).
deletar(_, [], NewBubbles).

updateBubbles(Bubbles, NewBubbles, Time) :-
    NewBubbles = Bubbles.