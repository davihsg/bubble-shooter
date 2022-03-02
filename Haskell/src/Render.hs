module Render where

import Graphics.Gloss
import GameBoard
import Models
import Util
import Update

render::BubbleShooter -> Picture 
render game @ Game {gameState = Playing } = translate (convertToFloat (-350)) (convertToFloat (-350)) frame
    where frame = pictures ([mkShooter $ shooter game] ++ (map mkBubble (bubbles game))) 
          
render game @ Game { gameState = Menu } =
    pictures [ mkText black "Bubble Shooter" 0.5 0.5 (-210) 200
             , mkText black "Init Game: press ENTER" 0.3 0.3 (-215) 100
             , mkText black "Back to Menu: press P" 0.3 0.3 (-220) (0)
             , mkText black "Quit Game: press ESC" 0.3 0.3 (-220) (-100)
             ]          
          
mkShooter::Shooter -> Picture
mkShooter _shooter = pictures [translate x y (shooterPicture _shooter), shootPicture _shooter (getAngle $ shooterAngle _shooter)]
    where
        (x, y) = shooterPos _shooter

mkBubble::Bubble -> Picture
mkBubble bubble = translate x y (bubblePicture bubble)
    where
        (x, y) = bubblePos bubble

mkText :: Color -> String -> Float -> Float -> Float -> Float -> Picture
mkText col text x y x' y' = translate x' y' $ scale x y $ color col $ Text text

shooterPicture::Shooter -> Picture
shooterPicture _shooter = 
    pictures ([rotate (getAngle $ shooterAngle _shooter) $ color black $ pictures [circleSolid 40, translate 0 30 $ rectangleSolid (60) (30)]])

shootPicture::Shooter -> Float -> Picture
shootPicture _shooter angle
    | onShoot _shooter == False = translate x 50 $ rotate angle $ translate 0 (y-50) $ bubblePicture b
    | otherwise = mkBubble b
    where
        b = bubbleShoot $ nextShoot _shooter
        (x, y) = bubblePos b

bubblePicture::Bubble -> Picture
bubblePicture bubble = color (bubbleColor bubble) $ circleSolid 20