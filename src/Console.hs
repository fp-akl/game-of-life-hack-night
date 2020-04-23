module Console where

import Control.Concurrent
import Data.Bool
import Data.List
import Data.Maybe
import GameOfLife
import System.Console.ANSI
import qualified System.Console.Terminal.Size as TS

showBoard :: Coord -> Coord -> Board -> String
showBoard (Coord sx sy) (Coord ex ey) board =
  intercalate "\n"
    . map (map (bool dead alive . isAlive board))
    . map (\y -> map (\x -> Coord x y) [sx .. ex])
    $ [sy .. ey]
  where
    alive = '█'
    dead = ' '

run :: Board -> IO ()
run board = do
  TS.Window height width <- fromMaybe (TS.Window 20 20) <$> TS.size
  clearScreen
  putStrLn $ showBoard (Coord 0 0) (Coord (width - 4) (height - 4)) board
  threadDelay (100 * 1000)
  run $ nextBoard board
