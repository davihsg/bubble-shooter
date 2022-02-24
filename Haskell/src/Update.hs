module Update where

import Models

update :: Float -> BubbleShooter -> BubbleShooter
update seconds = updateBubble

updateBubble :: BubbleShooter -> BubbleShooter
updateBubble game = game