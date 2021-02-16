module Grammar

import Lexer
import Values
import Text.Parser
import Text.Lexer.Core

public export
Rule : Type -> Type
Rule ty = Grammar TokenKind True ty


term : String -> TokenKind -> Rule Bool
term symbol y = terminal ("Error on processing '" ++ symbol ++ "'")
     (\x => if eq_tkn x y then 
               Just True 
            else 
               Nothing)

brackets : Rule Bool -> Rule Bool 
brackets exp = (term "[" LBracket) *> exp  <* (term "]" RBracket)

public export
parseToml : String -> Either
                  (ParseError TokenKind)
                  (Bool, List (TokenKind))

parseToml str = 
     let res = (lex_toml str) in
     case res of 
       Left (x) => (parse (brackets (term "." Dot)) [])
       Right list => parse (brackets (term "." Dot)) list 
       