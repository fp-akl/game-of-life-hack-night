{-# LANGUAGE TemplateHaskell #-}

module Main where

import Console
import Data.List
import qualified Data.Set as Set
import GameOfLife
import Hedgehog
import Hedgehog.Main

prop_parse :: Property
prop_parse =
  withTests 1 . property $
    let str =
          unlines
            [ "     ",
              " ... ",
              ""
            ]
     in parseBoard str
          === Board (Set.fromList [Coord 1 1, Coord 2 1, Coord 3 1])

prop_show :: Property
prop_show =
  withTests 1 . property $
    let str =
          intercalate
            "\n"
            [ "      ",
              " ███  ",
              "      "
            ]
     in showBoard
          (Coord 0 0)
          (Coord 5 2)
          (Board (Set.fromList [Coord 1 1, Coord 2 1, Coord 3 1]))
          === str

main :: IO ()
main = defaultMain [checkParallel $$(discover)]
