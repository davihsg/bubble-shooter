{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Util where

import Graphics.Gloss
import Models
import System.Random
import System.IO.Unsafe

convertToFloat::Int->Float
convertToFloat x = fromIntegral x :: Float

getAngle::Tuple -> Float
getAngle (0, _) = 0
getAngle (x, y) = - ((atan (y / x) * 180 / pi) + adjust x)

adjust::Float -> Float
adjust x
    | x < 0 = 90
    | x > 0 = 270
    | otherwise = 0

randomBubble::Float -> Float -> Bubble
randomBubble x y = Bubble
    { bubblePos = (x, y)
    , bubbleColor = randomColor
    }

randomColor::Color
randomColor 
    | c == 1 = dark red
    | c == 2 = dark blue
    | c == 3 = light green
    | c == 4 = yellow
    | otherwise = cyan
    where
        c = randomNumber(1,5)

randomNumber::(Int,Int) -> Int
randomNumber (a,b) = unsafePerformIO(randomRIO (a,b))

newShoot::Shoot
newShoot = Shoot
    { bubbleShoot = randomBubble 0 45
    , shootVel = (0, 0)
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

getVel::Tuple -> Tuple
getVel (x, y) = (x / k, y / k)
    where
        k = sqrt (((x * x) + (y * y)) / 49)
