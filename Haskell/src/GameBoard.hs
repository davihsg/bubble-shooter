module GameBoard where

import Graphics.Gloss
import Models
import Util

background :: Color
background =  makeColorI 153 153 255 140

width, height :: Int
width = 700
height = 700

fps::Int
fps = 1

initialState::BubbleShooter
initialState = Game
    { gameState = Menu
    , bubbles = []
    , shooter = getInitialShooter
    , time    = 0
    }
