module Values

import Data.SortedMap
import Data.List

mutual 

    public export
    data Value = 
        VStr String
        | VInt        Integer 
        | VFloat      Double 
        | VBool       Bool 
        | VDatetime   Integer
        | VArray      (List Value)  
        | VTable      ParsedToml

    public export
    ParsedToml : Type
    ParsedToml = (SortedMap String Value)

string_concat : String -> String -> String
string_concat acc current = acc ++ current

Show Value where 
    show (VStr x) = x
    show (VInt x) = show x
    show (VFloat x) = show x
    show (VBool x) = show x
    show (VDatetime x) = show x
    show (VArray x) =
        let arr = (foldl (string_concat) "" (map (\n => show n) x)) in  
        "[" ++ arr ++ "]"
    show (VTable x) = ?hole

acc_line : String -> (String, Value) -> String 
acc_line acc (name, val) = acc ++ name ++ " = " ++ (show val) ++ "\n"

