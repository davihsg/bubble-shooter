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
    | otherwise = _shooter {
        nextShoot = s {
            bubbleShoot = b {bubblePos = (x', y')}
            }
        }
    where
        (velx, vely) = shootVel (nextShoot _shooter)
        (x, y) = bubblePos $ bubbleShoot $ nextShoot _shooter
        x' = x + velx
        y' = y + vely
        s = nextShoot _shooter
        b = bubbleShoot s
    
offMap :: Shooter -> Bool
offMap _shooter
    | onShoot _shooter == False = False
    | x > 400 || x < -400 || y > 800 || y < -50 = True
    | otherwise = False  
    where 
        (x, y) = bubblePos $ bubbleShoot $ nextShoot _shooter

resetShooter::Shooter -> Shooter
resetShooter _shooter = _shooter
    { onShoot = False
    , nextShoot = newShoot}
  
-- Em desenvolvimento
checkBubbles ::  BubbleShooter -> [Bubble]
checkBubbles game =  filter(\bubble -> not (ishit (bubblePos bubble) ( shooterPos s))) (bubbles game)
	     where 
		s = shooter game 
		  
ishit :: Tuple -> Tuple -> Bool
ishit (b1x, b1y) (b2x, b2y) =
  b1x < b2x &&
  b1x  > b2x && b1y < b2y  && b1y > b2y
