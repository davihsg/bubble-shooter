module Render where

import Graphics.Gloss
import GameBoard
import Models
import Util

render::BubbleShooter -> Picture
render game = translate (convertToFloat width * (-0.5)) (convertToFloat height * (-0.5)) frame
    where frame = pictures [mkShooter $ shooter game]

mkShooter::Shooter -> Picture
mkShooter shooter = translate x y (shooterPicture shooter)
    where
        x = x_s shooter
        y = y_s shooter