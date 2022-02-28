module Render where

import Graphics.Gloss
import GameBoard
import Models
import Util
import Update


render::BubbleShooter -> Picture 
render game @ Game {gameState = Playing} = translate (convertToFloat width * (-0.5)) (convertToFloat height * (-0.5)) frame
    where frame = pictures ([mkShooter $ shooter game, mkBubble $ Bubble {x_b = x, y_b = y, color_b = blue}] ++ (map mkBubble (bubbles game)))
          (x, y) = ballloc game
          
render game @ Game { gameState = Menu } =
    pictures [ mkText black "Bubble Shooter" 0.5 0.5 (-210) 200
             , mkText black "Init Game: press ENTER" 0.3 0.3 (-215) 100
             , mkText black "Back to Menu: press P" 0.3 0.3 (-220) (0)
             , mkText black "Quit Game: press ESC" 0.3 0.3 (-220) (-100)
             ]          
          
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

mkText :: Color -> String -> Float -> Float -> Float -> Float -> Picture
mkText col text x y x' y' = translate x' y' $ scale x y $ color col $ Text text
        

