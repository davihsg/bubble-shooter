module Update where
import Util
import Graphics.Gloss
import Models

update :: Float -> BubbleShooter -> BubbleShooter
update seconds = updateBubble

updateBubble :: BubbleShooter -> BubbleShooter
updateBubble game = game

updateBubble game = game


updateShooterList :: [Bubble] -> [Bubble]
updateShooterList list = (tail list) 