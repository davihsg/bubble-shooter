module Models where
    
import Graphics.Gloss

type Tuple = (Float, Float)

data GameState = 
    Playing | Menu
    deriving Show

data Shoot = Shoot
    { bubbleShoot :: Bubble
    , shootVel    :: Tuple
    } deriving (Show, Eq)

data Bubble = Bubble
    { bubblePos   :: Tuple
    , bubbleColor :: Color
    } deriving (Show, Eq)

data Shooter = Shooter
    { shooterPos   :: Tuple
    , shooterAngle :: Tuple
    , onShoot      :: Bool
    , nextShoot    :: Shoot
    } deriving (Show, Eq)

data BubbleShooter = Game
    { gameState   :: GameState
    , bubbles     :: [Bubble]
    , shooter     :: Shooter
    , time        :: Float
    , score       :: Int
    , fallBubbles :: [Bubble]
    }

