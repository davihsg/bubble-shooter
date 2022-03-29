:- include('EventHandler.pl').
:- include('Render.pl').
:- include('Util.pl').

play(menu, Bubbles, Shooter, FallenBubbles, OnShoot, Time) :-
    sleep(1),

    handleEvent(menu, NewGameState, _, _, _, _),

    render(menu, _, _, _),

    play(NewGameState, [], [], [], 0, 0).

play(game, [], [], [], 0, 0) :-
    sleep(1),

    initialBubbles(NewBubbles),

    initialShooter(NewShooter),

    render(game, NewBubbles, NewShooter, []),

    play(game, NewBubbles, NewShooter, [], 0).

play(game, Bubbles, Shooter, FallenBubbles, OnShoot, Time) :-
    sleep(1),

    NewTime is Time + 1,

    handleEvent(game, Shooter, OnShoot, _, NewShooter, NewOnShoot),

    updateShooter(Bubbles, NewShooter, FallenBubbles, NewBubbles, FinalShooter, NewFallenBubbles),

    updateBubbles(NewBubbles, NewFallenBubbles, FinalBubbles, FinalFallenBubbles, NewTime),

    checkGameOver(NewBubbles, NewGameState),

    render(game, FinalBubbles, FinalShooter, FinalFallenBubbles),

    play(NewGameState, NewBubbles, FinalShooter, FinalFallenBubbles, NewOnShoot, NewTime).

main :-
    play(menu, [], [], [], 0, 0).