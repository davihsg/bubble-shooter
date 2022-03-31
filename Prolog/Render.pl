:- include('Util.pl').

render(menu, _, _) :-
    print_menu().

render(game, _, _) :- write("Game"), nl.
