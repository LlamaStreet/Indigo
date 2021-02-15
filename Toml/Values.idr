module Values

import Data.SortedMap

public export
data Value = VStr String
    | VInt        Integer 
    | VFloat      Double 
    | VBool       Bool 
    | VDatetime   Integer
    | VArray      (List Value)  
    | VTable      (SortedMap String Value)