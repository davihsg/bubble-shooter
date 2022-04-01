:- include('Util.pl').
:- include('Assets.pl').

render(menu, _, _, _) :-
    print_menu().

render(game, Bubbles, Shooter, OnShoot) :- 
        duplicate_(Aux),!,
        renderM(Bubbles, Aux, Matrix),
        renderShooter(Shooter, OnShoot, Matrix, NewMatrix),
        nl, print_to_str(NewMatrix).
