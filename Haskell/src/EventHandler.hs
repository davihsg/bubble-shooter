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

--Down = a tecla está pressionada
eventHandler (EventKey (SpecialKey KeyEnter) Down _ _  ) game@ Game { gameState = Menu} =
   game { gameState = Playing }

eventHandler (EventKey (Char 'p') Down _ _  ) game@ Game { gameState = Playing} =
   game { gameState = Menu}

eventHandler _ game = game

updateRotation::Shooter -> Tuple -> Shooter
updateRotation shooter (x, y) = shooter {shooterAngle = (x, y + 300)}

shootBubble::Shooter -> Tuple -> Shooter
shootBubble _shooter (x, y) = shoot $ updateRotation _shooter (x, y)

shoot::Shooter -> Shooter
shoot _shooter@Shooter {onShoot = False} =
    _shooter {nextShoot = (nextShoot _shooter){shootVel = (1, y / x)}}
    where
        (x, y) = shooterAngle _shooter
        
shoot _shooter@Shooter {onShoot = True} = _shooter
