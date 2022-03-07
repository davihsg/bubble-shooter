module Update where

import Util
import Graphics.Gloss
import Models

-- Update the Game
update :: Float -> BubbleShooter -> BubbleShooter
update seconds game =
    case (gameState game) of
        Menu -> game
        Playing -> updateBubble seconds game
        Win -> game
        Lose -> game

-- Update the Game on Playing scene. O estado de jogo e atualizado seguindo a ordem:
-- 1) Atualiza o tempo
-- 2) Atualiza o mapa
-- 3) Atualiza o atirador/tiro
-- 4) Atualiza as bolhas em queda
updateBubble :: Float -> BubbleShooter -> BubbleShooter
updateBubble seconds game = updateFallenBubbles $ updateShooter $ updateMap $ updateTime game

-- Atualiza o tempo e verifica se o jogo acabou.
updateTime :: BubbleShooter -> BubbleShooter
updateTime game
    | length ([b | b <- (bubbles game), (bubbleColor b) /= black]) == 0 = game { gameState = Win}
    | length (filter (checkBubblesLimit) (bubbles game)) > 0 = game { gameState = Lose }
    | otherwise = game { time = t + 1}
    where
        t = time game

-- Atualiza o atirador.
updateShooter:: BubbleShooter -> BubbleShooter
updateShooter game
    | onShoot (shooter game) == False = game
    | otherwise = updateShoot game

-- Atualiza o tiro. Move o tiro e depois verifica se houve colisao
updateShoot::BubbleShooter -> BubbleShooter
updateShoot game = checkCollision $ moveShoot game

-- Velocidade do tiro
bubbleSpeed::Float
bubbleSpeed = 4.5

-- Move o tiro. Um tiro possui um vetor velocidade (x, y). Para move-lo, basta incrementar a posicao do tiro
-- com o vetor velocidade multiplicado pela velocidade do tiro.
moveShoot::BubbleShooter -> BubbleShooter
moveShoot game
    | offMap _shoot = resetShooter game
    | otherwise = game
        { shooter = (shooter game)
            { nextShoot = _shoot}
        }
    where
        shoot = nextShoot $ shooter game
        (velx, vely) = shootVel shoot
        (x, y) = bubblePos $ bubbleShoot shoot
        x' = x + (velx * bubbleSpeed)
        y' = y + (vely * bubbleSpeed)
        
        _shoot = shoot
            { bubbleShoot = Bubble
                { bubblePos = (x', y')
                , bubbleColor = bubbleColor $ bubbleShoot shoot
                }
            }

-- Verifica se o tiro esta fora do mapa
offMap :: Shoot -> Bool
offMap shoot
    | x > 400 || x < (-400) || y > 400 || y < (-400) = True
    | otherwise = False  
    where 
        (x, y) = bubblePos $ bubbleShoot $ shoot

-- Reseta o atirador caso o tiro saia do mapa ou colida com alguma bolha
resetShooter::BubbleShooter -> BubbleShooter
resetShooter game = game
    { shooter = (shooter game)
        { onShoot = False
        , nextShoot = newShoot (time game)
        }
    }

-- Checa se o tiro colidiu com alguma bolha
checkCollision :: BubbleShooter -> BubbleShooter
checkCollision game
    | collided == [] = game
    | otherwise = fallenBubbles $ shootCollided game
    where
        _bubbleShoot = bubbleShoot $ nextShoot $ shooter game
        collided = checkBubbles _bubbleShoot $ bubbles game

-- Verifica se apos a colisao, o tiro conseguiu formar um combo de 3 bolhas e remove as bolhas destruidas
-- da lista de bolhas
shootCollided::BubbleShooter -> BubbleShooter
shootCollided game
    | length destroyedBubbles < 3 = resetShooter $ game {bubbles = (bubbles game) ++ [a]}
    | otherwise = resetShooter $ game
        { bubbles = filter (\b -> not (b `elem` destroyedBubbles)) $ ((bubbles game) ++ [a])
        , score = (score game) + (combo $ length destroyedBubbles)
        }
    where
        a = bubbleShoot $ nextShoot $ shooter game
        destroyedBubbles = getDestroyedBubbles a (bubbleColor a) ((bubbles game) ++ [a])

-- Retorna uma lista de bolhas destruidas por uma bolha
getDestroyedBubbles::Bubble -> Color -> [Bubble] -> [Bubble]
getDestroyedBubbles _ _ [] = []
getDestroyedBubbles a col bubbles = concatBubbles bubblesDestroyed
    where 
        -- Lista de bolhas adjacentes e com mesma cor
        _bubbles = filter (\b -> (isHit a b) && ((bubbleColor a) == (bubbleColor b))) bubbles

        -- Remove as bolhas adjacentes e com mesma cor para evitar loops infinitos
        newBubbles = filter (\b -> not (b `elem` _bubbles)) bubbles

        -- Chama a recursao para as bolhas adjacentes e une as listas de bolhas destruidas
        bubblesDestroyed = [getDestroyedBubbles b col newBubbles | b <- _bubbles] ++ [_bubbles]

-- Junta uma lista de listas em uma unica lista
concatBubbles::[[Bubble]] -> [Bubble]
concatBubbles [] = []
concatBubbles m = (head m) ++ (concatBubbles $ tail m)

-- Verifica quais bolhas cairam
fallenBubbles::BubbleShooter -> BubbleShooter
fallenBubbles game = game
    { bubbles = [x | x <- (bubbles game), not (x `elem` fallenBubble)]
    , score = (score game) + (combo $ length fallenBubble)
    , fallBubbles = (fallBubbles game) ++ fallenBubble
    }
    where
        -- O limiar e ultima linha de bolhas. Se uma bolha esta nesse nivel ou acima, está numa parede
        limiar = 370 - (((time game) / 720) * 3)

        -- Lista de bolhas que nao estao ligadas a uma parede direta ou indiretamente
        fallenBubble = [b | b <- (bubbles game), not $ (onWall b (bubbles game) limiar)]

-- Verifica se uma bolha esta ou nao ligada a uma parede direta ou indiretamente
onWall::Bubble -> [Bubble] -> Float -> Bool
onWall a bubbles limiar
    | y >= 330 = True
    | y >= limiar = True
    | otherwise = True `elem` ans
    where
        (_, y) = bubblePos a

        -- Lista de bolhas adjacentes
        _bubbles = filter (\b -> (isHit a b)) bubbles

        -- Remove as bolhas adjacentes para evitar loops infinitos
        newBubbles = filter (\b -> not (b `elem` _bubbles)) bubbles

        -- Chama a recursao para as bolhas adjacentes para verificar se esta ligada a parede indiretamente
        ans = [onWall b newBubbles limiar | b <- _bubbles]

-- Retorna a pontuacao do combo a partir do numero de bolas destruidas/caidas
combo::Int -> Int
combo n = (2 ^ n) - 1

-- Retorna a lista de bolhas adjacentes
checkBubbles :: Bubble -> [Bubble] -> [Bubble]
checkBubbles a bubbles = filter (\b -> isHit a b) bubbles

-- Verifica se uma bolha atingiu outra a partir da distancia euclidiana. Como o raio R da bolha e 20, entao
-- se a distancia entre seus centros for igual a 40 (2R), elas estao em contato uma com a outra.
-- 40 + 1 para evitar sobreposicoes uma vez que a bolha anda 4.5 pixels por frame
isHit :: Bubble -> Bubble -> Bool
isHit a b = dis < 41
    where
        (x, y) = bubblePos a
        (x', y') = bubblePos b
        dis = sqrt ((x - x') ** 2 + (y - y') ** 2)

-- Atualiza o mapa (desce as bolhas) a cada 720 frames.
updateMap::BubbleShooter -> BubbleShooter
updateMap game = game {bubbles = _bubbles}
    where
        _bubbles
            | mod (round(time game)) 720 == 0 = map shiftBubble $ bubbles game
            | otherwise = bubbles game

-- Shifta as bolhas para baixo 3 pixels
shiftBubble :: Bubble -> Bubble
shiftBubble bubble = Bubble{bubblePos = (fst (bubblePos bubble), snd (bubblePos bubble) - 3), bubbleColor = bubbleColor bubble}

-- Atualiza a posicao das bolhas em queda
updateFallenBubbles::BubbleShooter -> BubbleShooter
updateFallenBubbles game = game 
    {fallBubbles = [Bubble{bubblePos = (fst (bubblePos b), snd (bubblePos b) - (2 * bubbleSpeed)), bubbleColor = bubbleColor b} | b <- (fallBubbles game), (snd (bubblePos b)) > (-400)]}

-- Verifica se as bolhas chegaram perto do canhao, ou seja, fim de jogo
checkBubblesLimit::Bubble -> Bool
checkBubblesLimit bubble
        | y <= (-230) = True
        | otherwise = False
        where
            (x,y) = bubblePos bubble
