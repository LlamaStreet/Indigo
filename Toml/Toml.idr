module Toml

import Data.List
import Data.SortedMap
import Lexer
import Values 

public export 
deserialize : String -> (SortedMap String Value)
deserialize name = ?Parsed

public export
lookup : String -> (SortedMap String Value) -> (Maybe Value)
lookup name toml = SortedMap.lookup name toml 