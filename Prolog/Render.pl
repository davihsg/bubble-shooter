:- include('Util.pl').
:- include('Assets.pl').

render(menu, _, _) :-
    print_menu().

render(game, Bubbles, _) :- 
        
        duplicate_(Aux),!,
        % print_to_str(Aux),
        renderM(Bubbles, Aux, Matrix),
        % getMatrix(0,0,0,'A', Aux, Matrix), !,
        % write(Bubbles),
        print_to_str(Matrix),
        write("Game"), nl.
