module Routes exposing (Route(..), parseUrl)

import Url exposing (Url)
import Url.Parser as Url exposing ((</>), parse, top, oneOf, s, int)


type Route
    = Home
    | Category Int
    | Tag
    | Image
    | NotFound


parseUrl : Url -> Route
parseUrl =
    Maybe.withDefault NotFound <<
        parse
            (oneOf
                [ Url.map Home top
                , Url.map Category (s "category" </> int)
                , Url.map Tag (s "tag")
                , Url.map Image (s "image")
                ]
            )