:- include('EventHandler.pl').
:- include('Render.pl').
:- include('Util.pl').
:- include('Update.pl').
:-style_check(-discontiguous).
:-style_check(-singleton).

play(menu, _, _, _, _) :-
    render(menu, _, _, _, _),
    
    handleEvent(menu, _, _, NewGameState, _, _),

    play(NewGameState, [], [], false, []).

play(game, [], [], false, []) :-

    initialBubbles(NewBubbles),
    initialShooter(NewShooter),

    play(game, NewBubbles, NewShooter, false, []).

play(game, Bubbles, Shooter, OnShoot, FallenBubbles) :-
    sleep(1),

    % Rederiza a tela
    render(game, Bubbles, Shooter, OnShoot, FallenBubbles),

    % Recebe uma entrada
    handleEvent(game, Shooter, OnShoot, _, NewShooter, NewOnShoot),

    % Atualiza o shooter 
    updateShooter(Bubbles, NewShooter, FallenBubbles, NewOnShoot, NewBubbles, FinalShooter, NewFallenBubbles, FinalOnShoot),

    % Atualiza a posicao das bolhas
    updateFallenBubbles(NewFallenBubbles, FinalFallenBubbles),

    % Verifica se o jogo acabou
    checkGameOver(NewBubbles, NewGameState),
    
    % Continua o jogo
    play(NewGameState, NewBubbles, FinalShooter, FinalOnShoot, FinalFallenBubbles).