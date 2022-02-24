module GameBoard where

import Graphics.Gloss
import Models

background :: Color
background = white

width, height, xOffset, yOffset :: Int
width = 700
height = 700
xOffset = 600
yOffset = 0

fps::Int
fps = 30

initialState::BubbleShooter
initialState = Game
    { gameState = Menu
    , bubbles = []
    , shooter = Shooter{xS = 0, yS = 0}
    }