module EventHandler where

import Graphics.Gloss.Interface.Pure.Game
import Models
import GameBoard
import Util
import Update

-- Liga com os eventos do jogo
eventHandler::Event -> BubbleShooter -> BubbleShooter

-- Atualiza a rotacao do atirador baseado na movimentacao do mouse
eventHandler (EventMotion (x, y)) game@Game {gameState = Playing} =
    game {shooter = updateRotation (shooter game) (x, y)}

-- Atira a bolha ao apertar o botao esquerdo do mouse
eventHandler (EventKey (MouseButton LeftButton) Down _ (x, y)) game@Game {gameState = Playing} =
    game {shooter = shootBubble (shooter game) (x, y)}

-- Comeca o jogo ao apertar ENTER
eventHandler (EventKey (SpecialKey KeyEnter) Down _ _  ) game@ Game { gameState = Menu} =
    game { gameState = Playing
         , bubbles = getMapBubbles
         , shooter = getInitialShooter
         , score = 0
         , fallBubbles = []
         }

-- Retorna ao Menu
eventHandler (EventKey (Char 'p') Down _ _  ) game =
    game { gameState = Menu}

-- Cheat: Ganhar o jogo
eventHandler (EventKey (Char 'q') Down _ _  ) game@ Game { gameState = Playing} =
    game { bubbles = []}

eventHandler _ game = game

-- Atualizar a rotacao do atirador
updateRotation::Shooter -> Tuple -> Shooter
updateRotation shooter (x, y) = shooter {shooterAngle = (x, y + 300)}

-- Atira a bolha
shootBubble::Shooter -> Tuple -> Shooter
shootBubble _shooter@Shooter {onShoot = False} (x, y) = (updateRotation _shooter (x, y))
    {onShoot = True
    , nextShoot = (nextShoot _shooter)
        { bubbleShoot = (bubbleShoot (nextShoot _shooter))
            -- Muda a posicao inicial do tiro usando trigonometria e corrigindo as coordenadas
            { bubblePos = (cos angle * 40, sin angle * 40 - 300)}
        -- Cria o vetor velocidade do tiro
        , shootVel = getVel (x, y + 300)
        }
    }
    where
        (x', y') = shooterAngle _shooter
        angle = (90 - getAngle (x', y')) * pi / 180
        
shootBubble _shooter@Shooter {onShoot = True} _ = _shooter
