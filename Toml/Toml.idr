module Toml

import public Data.SortedMap
import public Values 
import Data.List
import Lexer
import Grammar

public export 
deserialize : String -> (SortedMap String Value)
deserialize name = ?Hole

public export
lookup : String -> (SortedMap String Value) -> (Maybe Value)
lookup name toml = SortedMap.lookup name toml 

