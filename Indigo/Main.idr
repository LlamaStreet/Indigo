module Main

import System
import Indigo.Commands

main : IO ()
main = do
  args <- getArgs
  action <- getAction args
  exitWith !(execCommand action)
  