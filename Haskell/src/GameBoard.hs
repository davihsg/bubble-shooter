module GameBoard where

import Graphics.Gloss
import Models
import Util

background :: Color
background =  makeColorI 153 153 255 140

width, height, xOffset, yOffset :: Int
width = 783
height = 783

fps::Int
fps = 60

initialState::BubbleShooter
initialState = Game
    { gameState = Menu
    , bubbles = []
    , shooter = getInitialShooter
    , time    = 0
    }
