module Render where

import Graphics.Gloss
import GameBoard
import Models
import Util
import Update

-- Renderiza a interface grafica
render::BubbleShooter -> Picture 

-- Caso esteja no Playing scene
render game @ Game {gameState = Playing } = frame
    where frame = pictures (map mkBubble (fallBubbles game) ++ [mkShooter $ shooter game] ++ (map mkBubble (bubbles game)) ++ [mkBoardRight] ++ [mkBoardLeft] ++ [mkBoard] ++ [mkscore game "Score: " (-300, -330) (0.25, 0.25)])

-- Caso esteja no Menu scene
render game @ Game { gameState = Menu } =
    pictures [ mkText black "Bubble Shooter" 0.5 0.5 (-210) 200
             , mkText black "Init Game: press ENTER" 0.3 0.3 (-215) 100
             , mkText black "Back to Menu: press P" 0.3 0.3 (-220) (0)
             , mkText black "Quit Game: press ESC" 0.3 0.3 (-220) (-100)
             ]

-- Caso esteja no Win scene
render game @ Game { gameState = Win } =
    pictures[mkText black "You win!" 0.5 0.5 (-130) (-30)
            , mkscore game ("Score: ") (-90, -100) (0.3, 0.3) 
    ]

-- Caso esteja no Lose scene
render game @ Game { gameState = Lose } =
    pictures[mkText black "Game over!" 0.5 0.5 (-190) (-30)]

-- Retorna a picture com o shooter na posicao e ja rotacionado 
mkShooter::Shooter -> Picture
mkShooter _shooter = pictures [shootPicture _shooter (getAngle $ shooterAngle _shooter), translate x y (shooterPicture _shooter)]
    where
        (x, y) = shooterPos _shooter

-- Retorna a picture da bolha na posicao
mkBubble::Bubble -> Picture
mkBubble bubble = translate x y (bubblePicture bubble)
    where
        (x, y) = bubblePos bubble

-- Retorna a picture do score do jogo na posicao
mkscore:: BubbleShooter -> [Char] -> Tuple -> Tuple -> Picture
mkscore game text (x, y) (x', y')= aux
               where
                num = show $ score $ game
                t = text ++ num
                aux = translate x y $ scale x' y' $ Text t 

-- Retorna a picture do texto na posicao
mkText :: Color -> String -> Float -> Float -> Float -> Float -> Picture
mkText col text x y x' y' = translate x' y' $ scale x y $ color col $ Text text

-- Retorna a picture do canhao
shooterPicture::Shooter -> Picture
shooterPicture _shooter = 
    pictures ([rotate (getAngle $ shooterAngle _shooter) $ color black $ pictures [circleSolid 40, translate 0 30 $ rectangleSolid (60) (30)]])

-- Retorna a picture do tiro
shootPicture::Shooter -> Float -> Picture
shootPicture _shooter angle
    | onShoot _shooter == False = translate x (y - 40) $ rotate angle $ translate 0 40 $ bubblePicture b
    | otherwise = mkBubble b
    where
        b = bubbleShoot $ nextShoot _shooter
        (x, y) = bubblePos b

-- Retorna a picture
bubblePicture::Bubble -> Picture
bubblePicture bubble = pictures [color (light black) $ circleSolid 20, color (bubbleColor bubble) $ circleSolid 18]

-- Retorna a borda a direita
mkBoardRight::Picture
mkBoardRight = pictures ([translate 365 200 $ color white $ rectangleSolid (25) (1100)])

-- Retorna a borda a esquerda
mkBoardLeft::Picture
mkBoardLeft = pictures ([translate (-365) 200 $ color white $ rectangleSolid (25) (1100)])

-- Retorna a borda inferior
mkBoard::Picture
mkBoard = pictures ([rotate (90) $ translate (365) (0) $ color white $ rectangleSolid (45) (750)])

