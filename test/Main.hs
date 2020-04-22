{-# LANGUAGE TemplateHaskell #-}

module Main where

import GameOfLife
import Hedgehog
import Hedgehog.Main

main :: IO ()
main = defaultMain [checkParallel $$(discover)]
