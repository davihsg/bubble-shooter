module Update where

import Util
import Graphics.Gloss
import Models

update :: Float -> BubbleShooter -> BubbleShooter
update = updateBubble

updateBubble :: Float -> BubbleShooter -> BubbleShooter
updateBubble seconds game@Game {gameState = Playing} = game
    {bubbles = checkBubbles game, shooter = updateShooter (shooter game)
    , time = updateTime game}

updateBubble _ game@Game {gameState = Menu} = game

updateTime :: BubbleShooter -> Float
updateTime game = t + 1 
    where
        t = time game

updateShooter:: Shooter -> Shooter
updateShooter _shooter 
    | offMap _shooter = resetShooter _shooter
    | onShoot _shooter == False = _shooter 
    | otherwise = _shooter
    { nextShoot = updateShoot (nextShoot _shooter)}

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

resetShooter::Shooter -> Shooter
resetShooter _shooter = _shooter
    { onShoot = False
    , nextShoot = newShoot}
  
-- Em desenvolvimento
checkBubbles :: BubbleShooter -> [Bubble]
checkBubbles game = filter (\b -> not (isHit (bubblePos b) (bubblePos $ bubbleShoot $ nextShoot s))) (bubbles game)
    where
        s = shooter game

isHit :: Tuple -> Tuple -> Bool
isHit (b1x, b1y) (b2x, b2y) = dis < 48
    where
        dis = sqrt ((b1x - b2x) * (b1x - b2x) + (b1y - b2y) * (b1y - b2y))
