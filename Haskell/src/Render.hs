module Render where

import Graphics.Gloss
import GameBoard
import Models
import Util
import Update

render::BubbleShooter -> Picture 
render game = translate (convertToFloat width * (-0.5)) (convertToFloat height * (-0.5)) frame
    where frame = pictures ([mkShooter $ shooter game] ++ (map mkBubble (bubbles game)))     
          
mkShooter::Shooter -> Picture
mkShooter shooter = translate x y (shooterPicture shooter)
    where
        (x, y) = shooterPos shooter

mkBubble::Bubble -> Picture
mkBubble bubble = translate x y (bubblePicture bubble)
    where
        (x, y) = bubblePos bubble