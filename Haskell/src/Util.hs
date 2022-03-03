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


randomBubble::Float -> Float -> Int -> Bubble
randomBubble x y z = Bubble
    { bubblePos = (x, y)
    , bubbleColor = randomColor z
    }
randomColor:: Int -> Color
randomColor z
    | c == 1 = dark red
    | c == 2 = dark blue
    | c == 3 = light green
    | c == 4 = cyan
    | otherwise = yellow
    where
        c = rem (randomNumber(1,5)*z) 5

randomNumber::(Int,Int) -> Int
randomNumber (a,b) = unsafePerformIO(randomRIO (a,b))

newShoot::Float -> Shoot
newShoot t = Shoot
    { bubbleShoot = randomBubble 0 45 (round t)
    , shootVel = (0, 0)
    }

getInitialShooter::Shooter
getInitialShooter = Shooter
    { shooterPos   = (350, 50)
    , shooterAngle = (0, 0)
    , onShoot      = False
    , nextShoot    = newShoot 1
    }

getMapBubbles::[Bubble] 
getMapBubbles = generateMatrix 10 740 3 0

generateMatrix::Float -> Float -> Int -> Float-> [Bubble]
generateMatrix x 200 z t= generateLine (x + (10*t)) 200 z 
generateMatrix x y z t= generateLine (x + (10*t)) y (z+7) ++ generateMatrix x (y - 20) (z+7) (1-t)

generateLine::Float -> Float ->Int -> [Bubble]
generateLine x y z
    | x > 340 = []
    | otherwise = [randomBubble x y z] ++ (generateLine (x + 20) y) (z+7)

getVel::Tuple -> Tuple
getVel (x, y) = (x / k, y / k)
    where
        k = sqrt (((x * x) + (y * y)) / 49)
