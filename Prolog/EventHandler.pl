:- include('Util.pl').

handleEvent(menu, _, _, NewGameState, _, _) :-
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
    write(OnShoot), nl,

    (
        rightKey(Key) -> moveRight(Shooter, NewShooter), NewOnShoot = OnShoot;
        leftKey(Key) -> moveLeft(Shooter, NewShooter), NewOnShoot = OnShoot;
        shootKey(Key), OnShoot = false -> shootBubble(Shooter, NewShooter), NewOnShoot = true;
        NewShooter = Shooter, NewOnShoot = OnShoot
    ),

    
    nl,
    write("ONSHOT?"), write(NewOnShoot), nl.

shootBubble([Pos, [_, Color]], [Pos, [Pos, Color]]).
