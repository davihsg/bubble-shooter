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
fps = 30

initialState::BubbleShooter
initialState = Game
    { gameState = Playing
    , bubbles = getMapBubbles
    , shooter = getInitialShooter
    , time    = 0
    }

getInitialShooter::Shooter
getInitialShooter = Shooter
    { shooterPos   = (350, 50)
    , shooterAngle = (0, 0)
    , onShoot      = False
    , nextShoot    = newShoot
    }

getMapBubbles::[Bubble] 
getMapBubbles = generateMatrix 10 340

generateMatrix::Float -> Float -> [Bubble]
generateMatrix x 200 = generateLine x 200 
generateMatrix x y = generateLine x y  ++ generateMatrix x (y - 20)

generateLine::Float -> Float -> [Bubble]
generateLine 330 y = [randomBubble 330 y]
generateLine x y = [randomBubble x y] ++ (generateLine (x+20) y)
