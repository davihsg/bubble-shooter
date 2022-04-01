:- initialization(main).
:- include('Gameboard.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

main :-
    play(menu, _, _, _, _).