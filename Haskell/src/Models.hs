module Models where

import Graphics.Gloss

type Angle = (Float, Float)

data GameState = 
    Playing | Menu
    deriving Show

data BubbleShooter = Game
    {   gameState :: GameState
      , bubbles   :: [Bubble]
      , shooter   :: Shooter
    } --deriving Show

data Bubble = Bubble
    { x_b     :: Float
    , y_b     :: Float
    , color_b :: Color
    } deriving (Show, Eq)

data Shooter = Shooter
    { x_s     :: Float
    , y_s     :: Float
    , angle_s :: Angle
    } deriving (Show, Eq)