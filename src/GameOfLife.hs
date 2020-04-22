module GameOfLife where

data Coord = Coord Int Int
  deriving (Show, Eq, Ord)

newtype Board = Board ()
  deriving (Show, Eq)

isAlive :: Board -> Coord -> Bool
isAlive = undefined

neighbours :: Coord -> [Coord]
neighbours (Coord x y) = undefined

nextBoard :: Board -> Board
nextBoard = undefined

parseBoard :: String -> Board
parseBoard = undefined
