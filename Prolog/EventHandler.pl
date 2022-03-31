:- include('Util.pl').

handleEvent(menu, Shooter, OnShoot, NewGameState, _, _) :-
    get_single_char(Key),

    write("Key: "),
    write(Key),
    nl,

    (
        start(Key) -> NewGameState = game;
        NewGameState = menu
    ),
    write(NewGameState).

handleEvent(game, Shooter, OnShoot, _, NewShooter, NewOnShoot) :-
    get_single_char(Key),

    (
        right(Key) -> rotate(1, Shooter, NewShooter);
        left(Key) -> rotate(-1, Shooter, NewShooter);
        shoot(Key), OnShoot = false -> NewOnShoot = true;
        NewShooter is Shooter, NewOnShoot = OnShoot
    ).