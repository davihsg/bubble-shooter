module EventHandler where

import Graphics.Gloss.Interface.Pure.Game
import Models

eventHandler::Event -> BubbleShooter -> BubbleShooter
eventHandler _ game = game