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
    , shooterList = []
    }

getInitialShooter::Shooter
getInitialShooter = Shooter
    { x_s = 350
    , y_s = 50
    , angle_s = (0, 0)
    }
getMapBubbles::[Bubble] 
getMapBubbles = generateMatrix 10 340

generateMatrix::Float -> Float -> [Bubble]
generateMatrix x 200 = generateLine x 200 
generateMatrix x y = generateLine x y  ++ generateMatrix x (y-20)

generateLine::Float -> Float -> [Bubble]
generateLine 330 y = [Bubble{x_b = 330, y_b = y, color_b = color}]
    where
        color = randomColor
generateLine x y = [Bubble{x_b = x, y_b = y, color_b = color}] ++ (generateLine (x+20) y)
    where
        color = randomColor

randomColor::Color
randomColor 
    | c == 1 = (dark red)
    | c == 2  = (dark blue)
    | c == 3  = (light green)
    | c == 4 = yellow
    | c == 5  = cyan
    where
        c = randomNumber


randomNumber::Int
randomNumber = 1
-- To Do
