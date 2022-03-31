:- include('Util.pl').

render(menu, _, _, _) :-
    print_menu().

render(game, _, _, _) :- write("Game"), nl.



