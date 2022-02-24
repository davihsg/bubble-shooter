module Main where

import Graphics.Gloss
import GameBoard
import Render
import EventHandler
import Update

window::Display
window = InWindow "Bubble Shooter" (width, height) (xOffset, yOffset)

main = play window background fps initialState render eventHandler update
