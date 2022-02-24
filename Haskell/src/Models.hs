module Models where

import Graphics.Gloss

data GameState = 
    Playing | Menu
    deriving Show

data BubbleShooter = Game
    {   gameState :: GameState
      , bubbles   :: [Bubble]
      , shooter   :: Shooter
    } --deriving Show

data Bubble = Bubble
    { x     :: Int
    , y     :: Int
    , color :: Color
    } deriving (Show, Eq)

data Shooter = Shooter
    { xS     :: Int
    , yS     :: Int
    , pictureS :: Picture 
    } deriving (Show, Eq)