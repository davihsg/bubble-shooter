module GameBoard where

import Graphics.Gloss
import Models
import Util

background :: Color
background =  makeColorI 153 153 255 140

width, height, xOffset, yOffset :: Int
width = 750
height = 700
xOffset = 10
yOffset = 10

fps::Int
fps = 120

initialState::BubbleShooter
initialState = Game
    { gameState   = Menu
    , bubbles     = []
    , shooter     = getInitialShooter
    , time        = 0
    , score       = 0
    , fallBubbles = []
    }
