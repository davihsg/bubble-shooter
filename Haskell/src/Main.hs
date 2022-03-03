module Main where

import Graphics.Gloss
import GameBoard
import Render
import EventHandler
import Update
import Util

window::Display
window = InWindow "Bubble Shooter" (width, height) 

main = do
    play window background fps initialState render eventHandler update
