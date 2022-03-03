module Update where

import Util
import Graphics.Gloss
import Models

update :: Float -> BubbleShooter -> BubbleShooter
update = updateBubble

updateBubble :: Float -> BubbleShooter -> BubbleShooter
updateBubble seconds game@Game {gameState = Playing} = game
    { bubbles = updateMap game, shooter = updateShooter (shooter game) game
    , time = updateTime game}

updateBubble _ game@Game {gameState = Menu} = game

updateTime :: BubbleShooter -> Float
updateTime game = t + 1 
    where
        t = time game

updateShooter:: Shooter -> BubbleShooter -> Shooter
updateShooter _shooter game@Game {gameState = Playing}
    | offMap _shooter = resetShooter _shooter game
    | onShoot _shooter == False = _shooter 
    | otherwise = _shooter
    { nextShoot = updateShoot (nextShoot _shooter)}

updateMap::BubbleShooter -> [Bubble]
updateMap game 
    | mod (round(time game)) 400 == 0 = map addBubble (bubbles game)
    | otherwise = bubbles game

addBubble :: Bubble -> Bubble
addBubble bubble = Bubble{bubblePos = (fst (bubblePos bubble), snd(bubblePos bubble)  - 20), bubbleColor = bubbleColor bubble}

updateShoot::Shoot -> Shoot
updateShoot _shoot =
    _shoot { bubbleShoot = b {bubblePos = (x', y')}}
    where
        (velx, vely) = shootVel _shoot
        (x, y) = bubblePos $ bubbleShoot _shoot
        x' = x + velx
        y' = y + vely
        b = bubbleShoot _shoot
    
offMap :: Shooter -> Bool
offMap _shooter
    | onShoot _shooter == False = False
    | x > 800 || x < -50 || y > 800 || y < -50 = True
    | otherwise = False  
    where 
        (x, y) = bubblePos $ bubbleShoot $ nextShoot _shooter

resetShooter::Shooter -> BubbleShooter -> Shooter
resetShooter _shooter game@Game {gameState = Playing} = _shooter
    { onShoot = False
    , nextShoot = newShoot (time game)}
  
-- Em desenvolvimento
checkBubbles :: BubbleShooter -> [Bubble]
checkBubbles game = filter (\b -> not (isHit (bubblePos b) (bubblePos $ bubbleShoot $ nextShoot s))) (bubbles game)
    where
        s = shooter game

isHit :: Tuple -> Tuple -> Bool
isHit (b1x, b1y) (b2x, b2y) = dis < 48
    where
        dis = sqrt ((b1x - b2x) * (b1x - b2x) + (b1y - b2y) * (b1y - b2y))
