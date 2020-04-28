module Routes exposing (Route(..), parseUrl)

import Url exposing (Url)
import Url.Parser as Url


type Route
    = Home
    | Category
    | Tag
    | Image
    | NotFound


parseUrl : Url -> Route
parseUrl =
    Maybe.withDefault NotFound <<
        Url.parse
            (Url.oneOf
                [ Url.map Home Url.top
                , Url.map Category (Url.s "category")
                , Url.map Tag (Url.s "tag")
                , Url.map Image (Url.s "image")
                ]
            )