:- include('Util.pl').

handleEvent(menu, Shooter, OnShoot, NewGameState, _, _) :-
    get_single_char(Key),

    (
        start(Key) -> NewGameState is "game";
        NewGameState is "menu"
    ).

handleEvent(game, Shooter, OnShoot, _, NewShooter, NewOnShoot) :-
    get_single_char(Key),

    (
        right(Key) -> rotate(1, Shooter, NewShooter);
        left(Key) -> rotate(-1, Shooter, NewShooter);
        shoot(Key), OnShoot = 0 -> NewOnShoot is 1;
        NewShooter is Shooter, NewOnShoot is OnShoot
    ).