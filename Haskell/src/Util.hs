module Util where

import Graphics.Gloss
import Models

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

shooterPicture::Shooter -> Picture
shooterPicture _shooter = rotate (getAngle $ shooterAngle _shooter) $ color black $ pictures [bubblePicture $ bubbleShoot (nextShoot _shooter), circleSolid 40, translate 0 30 $ rectangleSolid (60) (30)]

bubblePicture::Bubble -> Picture
bubblePicture bubble = color (bubbleColor bubble) $ translate x y $ circleSolid 20
    where
        (x, y) = bubblePos bubble

randomBubble::Float -> Float -> Bubble
randomBubble x y = Bubble
    { bubblePos = (x, y)
    , bubbleColor = randomColor
    }

randomColor::Color
randomColor 
    | c == 1  = (dark red)
    | c == 2  = (dark blue)
    | c == 3  = (light green)
    | c == 4  = yellow
    | c == 5  = cyan
    where
        c = randomNumber

randomNumber::Int
randomNumber = 1
-- TODO

newShoot::Shoot
newShoot = Shoot
    { bubbleShoot = randomBubble 0 20
    , shootVel = (0, 0)
    }
