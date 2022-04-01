:- include('Util.pl').
:- include('Assets.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

render(menu, _, _, _, _) :-
    print_menu().

render(game, Bubbles, Shooter, OnShoot, FallenBubbles) :- 
        duplicate_(Aux),!,
        renderM(Bubbles, Aux, Matrix),
        renderFB(FallenBubbles, Matrix, NewMatrix),
        renderShooter(Shooter, OnShoot, NewMatrix, FinalMatrix),
        nl, print_to_str(FinalMatrix).
