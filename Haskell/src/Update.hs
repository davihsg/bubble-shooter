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
updateBubble seconds game = updateFallenBubbles $ updateShooter $ updateMap $ updateTime game

updateTime :: BubbleShooter -> BubbleShooter
updateTime game 
    | length ([b | b <- (bubbles game), (bubbleColor b) /= black]) == 0 = game { gameState = Win}
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
bubbleSpeed = 4

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

checkCollision :: BubbleShooter -> BubbleShooter
checkCollision game
    | collided == [] = game
    | otherwise = fallenBubbles $ shootCollided game
    where
        _bubbleShoot = bubbleShoot $ nextShoot $ shooter game
        collided = checkBubbles _bubbleShoot $ bubbles game

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

getDestroyedBubbles::Bubble -> Color -> [Bubble] -> [Bubble]
getDestroyedBubbles _ _ [] = []
getDestroyedBubbles a col bubbles = concatBubbles bubblesDestroyed
    where 
        _bubbles = filter (\b -> (isHit a b) && ((bubbleColor a) == (bubbleColor b))) bubbles
        newBubbles = filter (\b -> not (b `elem` _bubbles)) bubbles

        bubblesDestroyed = [getDestroyedBubbles b col newBubbles | b <- _bubbles] ++ [_bubbles]

concatBubbles::[[Bubble]] -> [Bubble]
concatBubbles [] = []
concatBubbles m = (head m) ++ (concatBubbles $ tail m)

fallenBubbles::BubbleShooter -> BubbleShooter
fallenBubbles game = game
    { bubbles = [x | x <- (bubbles game), not (x `elem` fallenBubble)]
    , score = (score game) + (combo $ length fallenBubble)
    , fallBubbles = (fallBubbles game) ++ fallenBubble
    }
    where
        fallenBubble = [b | b <- (bubbles game), not $ (onWall b (bubbles game))]

onWall::Bubble -> [Bubble] -> Bool
onWall a bubbles 
    | y >= 330 = True
    | [b | b <- bubbles, (snd $ bubblePos b) > y] == [] = True
    | otherwise = True `elem` ans
    where
        (_, y) = bubblePos a
        _bubbles = filter (\b -> (isHit a b)) bubbles
        newBubbles = filter (\b -> not (b `elem` _bubbles)) bubbles

        ans = [onWall b newBubbles | b <- _bubbles]

combo::Int -> Int
combo n = (2 ^ n) - 1

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
            | mod (round(time game)) 720 == 0 = map shiftBubble $ bubbles game
            | otherwise = bubbles game

shiftBubble :: Bubble -> Bubble
shiftBubble bubble = Bubble{bubblePos = (fst (bubblePos bubble), snd (bubblePos bubble) - 3), bubbleColor = bubbleColor bubble}

updateFallenBubbles::BubbleShooter -> BubbleShooter
updateFallenBubbles game = game 
    {fallBubbles = [Bubble{bubblePos = (fst (bubblePos b), snd (bubblePos b) - 8), bubbleColor = bubbleColor b} | b <- (fallBubbles game), (snd (bubblePos b)) > (-400)]}

checkBubblesLimit::Bubble -> Bool
checkBubblesLimit bubble
        | y <= (-230) = True
        | otherwise = False
        where
            (x,y) = bubblePos bubble
