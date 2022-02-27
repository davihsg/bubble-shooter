module Update where

import Models
import Util
import Graphics.Gloss

update :: Float -> BubbleShooter -> BubbleShooter
update seconds = updateBubble

updateBubble :: BubbleShooter -> BubbleShooter
updateBubble game = game


updateShooterList :: [Bubble] -> [Bubble]
updateShooterList list = (tail list)