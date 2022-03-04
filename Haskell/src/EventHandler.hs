module EventHandler where

import Graphics.Gloss.Interface.Pure.Game
import Models
import GameBoard
import Util
import Update

eventHandler::Event -> BubbleShooter -> BubbleShooter

eventHandler (EventMotion (x, y)) game@Game {gameState = Playing} =
    game {shooter = updateRotation (shooter game) (x, y)}

eventHandler (EventKey (MouseButton LeftButton) Down _ (x, y)) game@Game {gameState = Playing} =
    game {shooter = shootBubble (shooter game) (x, y)}

eventHandler (EventKey (SpecialKey KeyEnter) Down _ _  ) game@ Game { gameState = Menu} =
    game { gameState = Playing
         , bubbles = getMapBubbles
         , shooter = getInitialShooter
         , score = 0
         , fallBubbles = []
         }

eventHandler (EventKey (Char 'p') Down _ _  ) game@ Game { gameState = Playing} =
    game { gameState = Menu}

eventHandler _ game = game

updateRotation::Shooter -> Tuple -> Shooter
updateRotation shooter (x, y) = shooter {shooterAngle = (x, y + 300)}

shootBubble::Shooter -> Tuple -> Shooter
shootBubble _shooter@Shooter {onShoot = False} (x, y) = (updateRotation _shooter (x, y))
    {onShoot = True
    , nextShoot = (nextShoot _shooter)
        { bubbleShoot = (bubbleShoot (nextShoot _shooter)) 
            { bubblePos = (cos angle * 40, sin angle * 40 - 300)}
        , shootVel = getVel (x, y + 300)
        }
    }
    where
        (x', y') = shooterAngle _shooter
        angle = (90 - getAngle (x', y')) * pi / 180
        
shootBubble _shooter@Shooter {onShoot = True} _ = _shooter
