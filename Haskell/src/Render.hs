module Render where

import Graphics.Gloss
import GameBoard
import Models
import Util

render::BubbleShooter -> Picture
render game = translate (convertToFloat width * (-0.5)) (convertToFloat height * (-0.5)) frame
    where frame = pictures [mkShooter $ shooter game]

mkShooter::Shooter -> Picture
mkShooter shooter = translate x y shooterPicture
    where
        shooterPicture = color black $ pictures [circleSolid 40, translate 0 40 $ rectangleSolid 50 40]
        x = x_s shooter
        y = y_s shooter