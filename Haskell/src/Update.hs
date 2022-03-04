module Update where

import Util
import Graphics.Gloss
import Models

update :: Float -> BubbleShooter -> BubbleShooter
update seconds game =
    case (gameState game) of
        Menu -> game
        Playing -> updateBubble seconds game
        Win -> game
        Lose -> game

updateBubble :: Float -> BubbleShooter -> BubbleShooter
updateBubble seconds game = updateShooter $ updateMap $ updateTime game

updateTime :: BubbleShooter -> BubbleShooter
updateTime game 
    | length (bubbles game) == 0 = game { gameState = Win}
    | length(filter (checkBubblesLimit) (bubbles game)) > 0 = game { gameState = Lose }
    | otherwise = game { time = t + 1}
    where
        t = time game

updateShooter:: BubbleShooter -> BubbleShooter
updateShooter game
    | onShoot (shooter game) == False = game
    | otherwise = updateShoot game

updateShoot::BubbleShooter -> BubbleShooter
updateShoot game = checkCollision $ moveShoot game

bubbleSpeed::Float
bubbleSpeed = 3

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

offMap :: Shoot -> Bool
offMap shoot
    | x > 400 || x < (-400) || y > 400 || y < (-400) = True
    | otherwise = False  
    where 
        (x, y) = bubblePos $ bubbleShoot $ shoot

resetShooter::BubbleShooter -> BubbleShooter
resetShooter game = game
    { shooter = (shooter game)
        { onShoot = False
        , nextShoot = newShoot (time game)
        }
    }
  
-- Em desenvolvimento
checkCollision :: BubbleShooter -> BubbleShooter
checkCollision game
    | collided == [] = game
    | otherwise = shootCollided game
    where
        _bubbleShoot = bubbleShoot $ nextShoot $ shooter game
        collided = checkBubbles _bubbleShoot $ bubbles game

shootCollided::BubbleShooter -> BubbleShooter
shootCollided game = resetShooter game{ bubbles = (bubbles game) ++ [b]}
    where
        b = bubbleShoot $ nextShoot $ shooter game

checkBubbles :: Bubble -> [Bubble] -> [Bubble]
checkBubbles a bubbles = filter (\b -> isHit a b) bubbles

isHit :: Bubble -> Bubble -> Bool
isHit a b = dis < 41
    where
        (x, y) = bubblePos a
        (x', y') = bubblePos b
        dis = sqrt ((x - x') ** 2 + (y - y') ** 2)

updateMap::BubbleShooter -> BubbleShooter
updateMap game = game {bubbles = _bubbles}
    where
        _bubbles
            | mod (round(time game)) 160 == 0 = map shiftBubble $ bubbles game
            | otherwise = bubbles game

shiftBubble :: Bubble -> Bubble
shiftBubble bubble = Bubble{bubblePos = (fst (bubblePos bubble), snd (bubblePos bubble) - 3), bubbleColor = bubbleColor bubble}

checkBubblesLimit::Bubble -> Bool
checkBubblesLimit bubble
        | y <= (-230) = True
        | otherwise = False
        where
            (x,y) = bubblePos bubble