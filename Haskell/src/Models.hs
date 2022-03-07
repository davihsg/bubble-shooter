module Models where
    
import Graphics.Gloss

type Tuple = (Float, Float)

-- Estado de jogo
data GameState = 
    Playing | Menu | Win | Lose
    deriving Show

-- Tiro
data Shoot = Shoot
    { bubbleShoot :: Bubble
    , shootVel    :: Tuple
    } deriving (Show, Eq)

-- Bolha
data Bubble = Bubble
    { bubblePos   :: Tuple
    , bubbleColor :: Color
    } deriving (Show, Eq)

-- Atirador
data Shooter = Shooter
    { shooterPos   :: Tuple
    , shooterAngle :: Tuple
    , onShoot      :: Bool
    , nextShoot    :: Shoot
    } deriving (Show, Eq)

-- Game BubbleShooter
data BubbleShooter = Game
    { gameState   :: GameState
    , bubbles     :: [Bubble]
    , shooter     :: Shooter
    , time        :: Float
    , score       :: Int
    , fallBubbles :: [Bubble]
    }

