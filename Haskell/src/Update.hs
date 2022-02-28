module Update where
import Util
import Graphics.Gloss
import Models

update :: Float -> BubbleShooter -> BubbleShooter
update seconds game = updateBubble seconds game 

updateBubble :: Float -> BubbleShooter -> BubbleShooter
updateBubble seconds game | offmap game == False = game {ballloc = moveBall (time game) game, time = updateTime game}
			   | otherwise = game {ballRun = False, ballloc = (175, 50), time = updateTime game}

updateShooterList :: [Bubble] -> [Bubble]
updateShooterList list = (tail list)

updateTime :: BubbleShooter -> Float
updateTime game = t + 1 
      	where
          t = time game

-- Em desenvolvimento
moveBall :: Float -> BubbleShooter -> (Float, Float)
moveBall seconds game@Game {ballRun=True} = (x' , y')
		       		      where
		       		       -- posição velha e ultimo click
			                       (x, y) = ballloc game
			                       (xs, ys) = lastClick game 
			                       -- calculando angulo
			                       a = atan (xs/ys)
			                       ar = a * (pi/180)
			                       -- calculando x e y
			                       vel = ballvel game
			                       vx = (sin ar) * vel  
			                       vy = (cos ar) * vel
			                       -- nova posição 
			                       x' = x + vx
			                       y' = y + vy
			                       
moveBall seconds game@Game {ballRun=False} = (x' , y')
		       		       where
			                         (x', y') = ballloc game
    
    
offmap :: BubbleShooter -> Bool
offmap game | x > 350 || x < 0 || y > 356 || y < 0 = True
            | otherwise = False  
            where 
              (x, y) = ballloc game 
