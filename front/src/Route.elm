import Url.Parser exposing (Parser, (</>), int, map, oneOf, s, string)

type Route
  = Categorie String
  | Image Int
  | Tag String

routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ map Categorie   (s "Categorie" </> string)
    , map Image    (s "Image" </> string)
    , map Tag    (s "Tag" </> string)
    ]
