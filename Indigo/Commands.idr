module Indigo.Commands

import Data.SortedMap
import System
import Values
import System.Directory

public export
data Action : Type where
  Build : (config : ParsedToml) -> Action
  FetchDeps : (config : ParsedToml) -> Action
  Init : (name : String) -> (path : String) -> Action
  Help : Action
  UnknownCommand : Action

public export
Show Action where
  show (Build config) = "Build(SortedMap)"
  show (FetchDeps config) = "FetchDeps(SortedMap)"
  show (Init name path) = "Init(" ++ name ++ ", " ++ path ++ ")"
  show Help = "Help"
  show UnknownCommand = "UnkwnownCommand"

public export
getAction : HasIO io => List String -> io Action
getAction (_::"build"::args) = pure $ Build Data.SortedMap.empty -- TODO(read config file)
getAction (_::"fetch"::args) = pure $ FetchDeps Data.SortedMap.empty -- TODO(read config file)
getAction (_::"help"::args) = pure $ Help
getAction (_::"init"::name::args) = do
  pwd <- currentDir

  case pwd of
    Just dir => pure $ Init name dir
    Nothing => pure Help
getAction _ = pure UnknownCommand

public export
execCommand : Action -> IO ExitCode

execCommand UnknownCommand = do
  putStrLn "Usage: indigo <command> [...args]"

  pure $ ExitFailure 1

execCommand Help = do
  putStrLn "Usage: indigo <command> [...args]"
  putStrLn "  indigo build"
  putStrLn "  indigo fetch"
  putStrLn "  indigo init <name>"

  pure $ ExitFailure 1

execCommand (Init name path) = do
  putStrLn "Initing..."

  pure ExitSuccess

execCommand (Build config) = do
  putStrLn "Building..."

  pure ExitSuccess

execCommand (FetchDeps config) = do
  putStrLn "Fetching dependencies"

  pure ExitSuccess
