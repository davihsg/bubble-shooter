updateShooter(Bubbles, Shooter, FallenBubbles, NewBubbles, NewShooter, NewFallenBubbles) :-
    NewBubbles is Bubbles,
    NewShooter is Shooter,
    NewFallenBubbles is FallenBubbles.

updateBubbles(Bubbles, FallenBubbles, NewBubbles, NewFallenBubbles, Time) :-
    NewBubbles is Bubbles,
    NewFallenBubbles is FallenBubbles.