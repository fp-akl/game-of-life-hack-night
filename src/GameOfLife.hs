{-# LANGUAGE UnicodeSyntax #-}

module GameOfLife where

import Control.Monad
import Data.Char (isSpace)
import Data.List (findIndices)
import Data.Set (Set)
import qualified Data.Set as Set

data Coord = Coord Int Int
  deriving (Show, Eq, Ord)

data Board
  = Board
      { bAlives :: Set Coord
        -- , _bNeighbours :: Set Coord
      }
  deriving (Show, Eq)

isAlive :: Board -> Coord -> Bool
isAlive (Board b) c = Set.member c b

neighbours :: Coord -> [Coord]
neighbours (Coord x y) = do
  dx <- [-1 .. 1]
  dy <- [-1 .. 1]
  guard $ dx /= 0 || dy /= 0
  return (Coord (x + dx) (y + dy))

nextAlive :: Board -> Coord -> Bool
nextAlive board curr =
  case numAliveNeighbours of
    2 -> isAlive board curr
    3 -> True
    _ -> False
  where
    numAliveNeighbours =
      length
        . filter (isAlive board)
        $ neighbours curr

nextBoard :: Board -> Board
nextBoard board =
  Board
    . Set.filter (nextAlive board)
    . Set.fromList
    . concatMap (\i -> i : neighbours i)
    $ bAlives board

parseBoard :: String -> Board
parseBoard =
  Board
    . Set.fromList
    . concatMap (\(y, xs) -> map (\x -> Coord x y) xs)
    . zip [0 ..]
    . map (findIndices (not . isSpace))
    . lines
