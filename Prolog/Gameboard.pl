:- include('EventHandler.pl').
:- include('Render.pl').
:- include('Util.pl').
:- include('Update.pl').

play(menu, Bubbles, Shooter, OnShoot, Time) :-
    sleep(1),
    render(menu, _, _),
    
    handleEvent(menu, _, _, NewGameState, _, _),

    play(NewGameState, [], [], false, 0).

play(game, [], [], false, 0) :-
    sleep(1),
    initialBubbles(NewBubbles),
    initialShooter(NewShooter),

    play(game, NewBubbles, NewShooter, false, 0).

play(game, Bubbles, Shooter, OnShoot, Time) :-
    
    % Rederiza a tela
    render(game, Bubbles, Shooter),

    % Incrementa o tempo
    NewTime is Time + 1,

    % Recebe uma entrada
    handleEvent(game, Shooter, OnShoot, _, NewShooter, NewOnShoot),

    % Atualiza o shooter 
    updateShooter(Bubbles, NewShooter, NewOnShoot, NewBubbles, FinalShooter, FinalOnShoot),

    % Atualiza a posicao das bolhas
    %updateBubbles(NewBubbles, FinalBubbles, NewTime),
    FinalBubbles = NewBubbles,

    % Verifica se o jogo acabou
    checkGameOver(FinalBubbles, NewGameState),
    
    % Continua o jogo
    play(NewGameState, FinalBubbles, FinalShooter, FinalOnShoot, NewTime).