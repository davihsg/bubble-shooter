module GameBoard where

import Graphics.Gloss
import Models
import Util

-- Cor do background
background :: Color
background =  makeColorI 153 153 255 140

-- Dimencoes da tela
width, height, xOffset, yOffset :: Int
width = 750
height = 700
xOffset = 10
yOffset = 10

-- Frames per second
fps::Int
fps = 100

-- Estado initial do jogo
initialState::BubbleShooter
initialState = Game
    { gameState   = Menu
    , bubbles     = []
    , shooter     = getInitialShooter
    , time        = 0
    , score       = 0
    , fallBubbles = []
    }
