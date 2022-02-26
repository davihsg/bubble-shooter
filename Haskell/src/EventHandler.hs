module EventHandler where

import Graphics.Gloss.Interface.Pure.Game
import Models
import GameBoard
import Util

eventHandler::Event -> BubbleShooter -> BubbleShooter

eventHandler (EventMotion (x, y)) game@Game {gameState = Playing} =
    game {shooter = updateRotation (shooter game) (x, y)}

eventHandler _ game = game

updateRotation::Shooter -> Angle -> Shooter
updateRotation shooter (a, b) = shooter {angle_s = (a, b + 300)}