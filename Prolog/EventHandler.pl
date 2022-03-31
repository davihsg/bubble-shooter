:- include('Util.pl').

handleEvent(menu, Shooter, OnShoot, NewGameState, _, _) :-
    get_single_char(Key),

    write("Key: "),
    write(Key),
    nl,

    (
        startKey(Key) -> NewGameState = game;
        NewGameState = menu
    ),
    write(NewGameState), nl.

handleEvent(game, Shooter, OnShoot, _, NewShooter, NewOnShoot) :-
    get_single_char(Key),

    write("Key: "),
    write(Key),
    nl,

    (
        rightKey(Key) -> rotateRight(Shooter, NewShooter);
        leftKey(Key) -> rotateLeft(Shooter, NewShooter);
        shootKey(Key), OnShoot = false -> NewOnShoot = true;
        NewShooter = Shooter, NewOnShoot = OnShoot
    ).