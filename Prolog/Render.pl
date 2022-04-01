:- include('Util.pl').
:- include('Assets.pl').

render(menu, _, _) :-
    print_menu().

render(game, Bubbles, _) :- 
        duplicate_(Aux),!,
        renderM(Bubbles, Aux, Matrix),
        print_to_str(Matrix).
