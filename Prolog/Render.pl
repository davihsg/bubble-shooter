:- include('Util.pl').

render(menu, _, _) :-
    print_menu().

render(game, Bubbles, Shooter) :-
    write("Game:"), nl,
    write(Bubbles), nl,
    write(Shooter), nl, nl.
