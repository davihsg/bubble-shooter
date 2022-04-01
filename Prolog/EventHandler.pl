:- include('Util.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

handleEvent(menu, _, _, NewGameState, _, _) :-
    get_single_char(Key),

    (
        startKey(Key) -> NewGameState = game;
        NewGameState = menu
    ).

handleEvent(game, Shooter, OnShoot, _, NewShooter, NewOnShoot) :-
    get_single_char(Key),

    (
        rightKey(Key) -> moveRight(Shooter, NewShooter), NewOnShoot = OnShoot;
        leftKey(Key) -> moveLeft(Shooter, NewShooter), NewOnShoot = OnShoot;
        shootKey(Key), OnShoot = false -> shootBubble(Shooter, NewShooter), NewOnShoot = true;
        NewShooter = Shooter, NewOnShoot = OnShoot
    ).

shootBubble([Pos, [_, Color]], [Pos, [Pos, Color]]).
