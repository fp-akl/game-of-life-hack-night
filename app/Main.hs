{-# LANGUAGE LambdaCase #-}

module Main where

import qualified Console
import GameOfLife
import System.Environment
import System.Exit
import System.IO

main :: IO ()
main = do
  board <- getArgs >>= \case
    [fp] -> parseBoard <$> readFile fp
    _ -> do
      hPutStrLn stderr "Usage: ./game-of-life <board_path>"
      exitWith (ExitFailure 1)
  Console.run board
