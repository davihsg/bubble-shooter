module Util where

import Graphics.Gloss
import Models
import System.Random
import System.IO.Unsafe

-- Converte de inteiro para float
convertToFloat::Int->Float
convertToFloat x = fromIntegral x :: Float

-- Retorna o angulo em graus a partir de um vetor (x, y)
getAngle::Tuple -> Float
getAngle (0, _) = 0
getAngle (x, y) = - ((atan (y / x) * 180 / pi) + adjust x)

-- Ajusta o angulo baseado nos quadrantes do X
adjust::Float -> Float
adjust x
    | x < 0 = 90
    | x > 0 = 270
    | otherwise = 0

-- Retorna uma bolha aleatoria
randomBubble::Float -> Float -> Int -> Bubble
randomBubble x y z = Bubble
    { bubblePos = (x, y)
    , bubbleColor = randomColor z
    }

-- Retorna uma cor aleatoria
randomColor:: Int -> Color
randomColor z
    | c == 1 = dark red
    | c == 2 = dark blue
    | c == 3 = light green
    | c == 4 = cyan
    | otherwise = yellow
    where
        c = rem (randomNumber(1,5)*z) 5

-- Retorna um numero aleatorio
randomNumber::(Int,Int) -> Int
randomNumber (a,b) = unsafePerformIO(randomRIO (a,b))

-- Retorna um novo atirador
newShoot::Float -> Shoot
newShoot t = Shoot
    { bubbleShoot = randomBubble 0 (-260) (round t)
    , shootVel = (0, 0)
    }

-- Retorna o atirador inicial
getInitialShooter::Shooter
getInitialShooter = Shooter
    { shooterPos   = (0, -300)
    , shooterAngle = (0, 0)
    , onShoot      = False
    , nextShoot    = newShoot 1
    }

-- Retorna o mapa de bolhas
getMapBubbles::[Bubble] 
getMapBubbles = (generateMatrix (-320) 370 3 0) ++ getEndBubbles

-- Retorna duas linhas de bolhas pretas para indicar o fim
getEndBubbles::[Bubble]
getEndBubbles = (generateEndLine (-320) 410) ++ (generateEndLine (-320) 450)

-- Gera uma linha de bolhas petras
generateEndLine::Float -> Float -> [Bubble]
generateEndLine x y
    | x > 320 = []
    | otherwise = [b] ++ (generateEndLine (x + 40) y)
    where b = Bubble {bubblePos = (x, y), bubbleColor = black}

-- Gera uma matriz de bolhas com cores aleatorias
generateMatrix::Float -> Float -> Int -> Float-> [Bubble]
generateMatrix x y z t 
    | y <= 120 = generateLine (x + (15*t)) y z 
    | otherwise = generateLine (x + (15*t)) y (z+7) ++ generateMatrix x (y - 40) (z+7) (t)

-- Gera uma linha de bolhas com cores aleatorias
generateLine::Float -> Float ->Int -> [Bubble]
generateLine x y z
    | x > 320 = []
    | otherwise = [randomBubble x y z] ++ (generateLine (x + 40) y) (z+7)

-- Retorna um vetor equivalente cujo comprimento seja 1 pixel
getVel::Tuple -> Tuple
getVel (x, y) = (x / k, y / k)
    where
        k = sqrt ((x * x) + (y * y))