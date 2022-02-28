module EventHandler where

import Graphics.Gloss.Interface.Pure.Game
import Models
import GameBoard
import Util
import Update

eventHandler::Event -> BubbleShooter -> BubbleShooter

eventHandler (EventMotion (x, y)) game@Game {gameState = Playing} =
    game {shooter = updateRotation (shooter game) (x, y)}

--ignorar 
--eventHandler (EventKey (SpecialKey KeySpace) Down _ _) game@Game {gameState = Playing, ballRun = False} = game{ballRun = True}

eventHandler (EventKey (MouseButton LeftButton) Down _ (x', y')) game = game{lastClick=(x', y'), ballRun=True}

eventHandler _ game = game

updateRotation::Shooter -> Angle -> Shooter
updateRotation shooter (a, b) = shooter {angle_s = (a, b + 300)}



