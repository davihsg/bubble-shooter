module Render where

import Graphics.Gloss
import GameBoard
import Models
import Util
import Update

render::BubbleShooter -> Picture 
render game = translate (convertToFloat width * (-0.5)) (convertToFloat height * (-0.5)) frame
    where frame = pictures ([mkShooter $ shooter game] ++ (map mkBubble (bubbles game))) 
          
render game @ Game { gameState = Menu } =
    pictures [ mkText black "Bubble Shooter" 0.5 0.5 (-210) 200
             , mkText black "Init Game: press ENTER" 0.3 0.3 (-215) 100
             , mkText black "Back to Menu: press P" 0.3 0.3 (-220) (0)
             , mkText black "Quit Game: press ESC" 0.3 0.3 (-220) (-100)
             ]          
          
mkShooter::Shooter -> Picture
mkShooter shooter = translate x y (shooterPicture shooter)
    where
        (x, y) = shooterPos shooter

mkBubble::Bubble -> Picture
mkBubble bubble = translate x y (bubblePicture bubble)
    where
        (x, y) = bubblePos bubble

mkText :: Color -> String -> Float -> Float -> Float -> Float -> Picture
mkText col text x y x' y' = translate x' y' $ scale x y $ color col $ Text text
        

