module GameBoard where

import Graphics.Gloss
import Models
import Util

background :: Color
background = white

width, height :: Int
width = 700
height = 700

fps::Int
fps = 30

initialState::BubbleShooter
initialState = Game
    { gameState = Menu
    , bubbles = []
    , shooter = getShooter
    }

getShooter::Shooter
getShooter = Shooter
    { x_s = convertToFloat width / 2
    , y_s = 50
    }