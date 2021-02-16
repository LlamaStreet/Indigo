module Lexer

import Text.Lexer

public export
data TokenKind
    = StringLit String
    | DateLit Integer
    | NumberLit Integer
    | FloatLit Double
    | Identifier String 
    | TrueLit
    | FalseLit
    | LBracket
    | RBracket
    | LCurly
    | RCurly
    | Dot
    | Comma
    | Eq 
    | Sharp
    | Whitespace
    | EOF

public export 
eq_tkn : TokenKind -> TokenKind -> Bool
eq_tkn (StringLit _) (StringLit _) = True
eq_tkn (DateLit _) (DateLit _) = True
eq_tkn (NumberLit _) (NumberLit _) = True
eq_tkn (FloatLit _) (FloatLit _) = True
eq_tkn (Identifier _) (Identifier _) = True
eq_tkn FalseLit FalseLit = True
eq_tkn TrueLit TrueLit = True
eq_tkn Sharp Sharp = True
eq_tkn Eq Eq = True
eq_tkn Comma Comma = True
eq_tkn Dot Dot = True
eq_tkn LCurly LCurly = True
eq_tkn RCurly RCurly = True
eq_tkn LBracket LBracket = True
eq_tkn RBracket RBracket = True

eq_tkn a b = False

export
opChars : String
opChars = "+-*"

operator : Lexer
operator = some (oneOf opChars)

toInt' : String -> Integer
toInt' = cast

public export
keyword : Lexer
keyword = some (pred (\x => isAlphaNum x || x == '-' || x == '_'))

public export
string : Lexer
string = (is '"') <+> some (pred (\x => x /= '"')) <+> (is '"')


public export
token_map : TokenMap TokenKind
token_map =
   [(digits <+> (is '.') <+> digits, \x => FloatLit (cast x)), 
   (digits, \x => NumberLit (cast x)),
   (is '[' ,\x => LBracket),
   (is ']' ,\x => RBracket),
   (is '{' ,\x => LCurly),
   (is '}' ,\x => RCurly),
   (is '#' ,\x => Sharp),
   (is '=' ,\x => Eq),
   (string ,\x => StringLit x),
   (space  ,\x => Whitespace),
   (keyword, \x => case x of 
            "true" => TrueLit
            "false" => FalseLit
            x => Identifier x)]

public export
lex_toml : String -> Either (Int, Int) (List TokenKind)
lex_toml str
  = case lex token_map str of
         (tokens, _, _, "") => Right $ map TokenData.tok tokens
         (_, line, column, _) => Left $ (line, column)

