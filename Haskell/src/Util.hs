module Util where

import Graphics.Gloss
import Models

convertToFloat::Int->Float
convertToFloat x = fromIntegral x :: Float
