:- initialization(main).
:- include('Gameboard.pl').

main :-
    play(menu, [], [], 0, 0).