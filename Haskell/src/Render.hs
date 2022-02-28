module Render where

import Graphics.Gloss
import GameBoard
import Models
import Util
import Update


render::BubbleShooter -> Picture 
render game = translate (convertToFloat width * (-0.5)) (convertToFloat height * (-0.5)) frame
    where frame = pictures ([mkShooter $ shooter game, mkBubble $ Bubble {x_b = convertToFloat 10, y_b = convertToFloat 30, color_b = blue}, mkBubble $ Bubble {x_b = x, y_b = y, color_b = blue}] ++ (map mkBubble (bubbles game)))
          (x, y) = ballloc game
          
          
mkShooter::Shooter -> Picture
mkShooter shooter = translate x y (shooterPicture shooter)
    where
        x = x_s shooter
        y = y_s shooter


mkBubble::Bubble -> Picture
mkBubble bubble = translate x y (bubblePicture bubble)
    where
        y = y_b bubble
        x = x_b bubble



mkBubbleShooter::Bubble -> Picture
mkBubbleShooter bubble = translate x y (bubblePicture bubble)
    where
        y = y_b bubble
        x = x_b bubble 
        

