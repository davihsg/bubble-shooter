:- include('EventHandler.pl').
:- include('Render.pl').
:- include('Util.pl').
:- include('Update.pl').

play(menu, Bubbles, Shooter, OnShoot, Time) :-
    sleep(1),
    render(menu, _, _, _),
    
    handleEvent(menu, _, _, NewGameState, _, _),
    nl, write("GameState: "), write(NewGameState), nl,

    play(NewGameState, [], [], false, 0).

play(game, [], [], false, 0) :-
    sleep(1),
    nl, write("Zerou"), nl, 

    render(game, NewBubbles, NewShooter, []),
    
    initialBubbles(NewBubbles),

    initialShooter(NewShooter),

    play(game, NewBubbles, NewShooter, false, 0).

play(game, Bubbles, Shooter, OnShoot, Time) :-
    sleep(1),
    
    % Rederiza a tela
    render(game, FinalBubbles, FinalShooter, FinalFallenBubbles),

    nl, write("Received"), nl,
    write(Bubbles), nl,
    write(Shooter), nl,
    write(OnShoot), nl,
    write(Time), nl,

    % Incrementa o tempo
    NewTime is Time + 1,

    % Recebe uma entrada
    handleEvent(game, Shooter, OnShoot, _, NewShooter, NewOnShoot),

    write(NewShooter), nl,
    write(NewOnShoot), nl,

    % Atualiza o shooter 
    updateShooter(Bubbles, NewShooter, NewOnShoot, NewBubbles, FinalShooter, FinalOnShoot),

    nl, write("Update Shooter"), nl,
    write(NewBubbles), nl,
    write(NewShooter), nl,
    write(FinalShooter), nl,

    % Atualiza a posicao das bolhas
    updateBubbles(NewBubbles, FinalBubbles, NewTime),

    nl, write("Update Bubbles"), nl,
    write(FinalBubbles), nl,
    write(NewTime), nl,

    % Verifica se o jogo acabou
    checkGameOver(FinalBubbles, NewGameState),

    nl, write("GameState"), nl,
    write(NewGameState), nl,
    
    % Continua o jogo
    play(NewGameState, FinalBubbles, FinalShooter, FinalOnShoot, NewTime).