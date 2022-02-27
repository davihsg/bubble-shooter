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
    { gameState = Playing
    , bubbles = []
    , shooter = getInitialShooter
    , shooterList = []
    }

getInitialShooter::Shooter
getInitialShooter = Shooter
    { x_s = 350
    , y_s = 50
    , angle_s = (0, 0)
    }