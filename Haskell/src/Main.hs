module Main where

import Graphics.Gloss
import GameBoard

window::Display
window = InWindow "Bubble Shooter" (width, height) (xOffset, yOffset)

main = display window background (Circle 80)
