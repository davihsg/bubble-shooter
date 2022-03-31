updateShooter(Bubbles, Shooter, FallenBubbles, NewBubbles, NewShooter, NewFallenBubbles) :-
    NewBubbles = Bubbles,
    NewShooter = Shooter,
    NewFallenBubbles = FallenBubbles.

updateBubbles(Bubbles, FallenBubbles, NewBubbles, NewFallenBubbles, Time) :-
    NewBubbles = Bubbles,
    NewFallenBubbles = FallenBubbles.