module Util where

import Graphics.Gloss
import Models

convertToFloat::Int->Float
convertToFloat x = fromIntegral x :: Float

getAngle::Angle -> Float
getAngle (0, _) = 0
getAngle (x, y) = - ((atan (y / x) * 180 / pi) + adjust x)

adjust::Float -> Float
adjust x
    | x < 0 = 90
    | x > 0 = 270
    | otherwise = 0

shooterPicture::Shooter -> Picture
shooterPicture _shooter = rotate (getAngle $ angle_s _shooter) $ color black $ pictures [circleSolid 40, translate 0 30 $ rectangleSolid (60) (30)]