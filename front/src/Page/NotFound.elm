module Page.NotFound exposing (view)

import Html exposing (Html, section, div, text)


---- VIEW ----


view : Html msg
view =
    section []
        [ div []
            [ text "Page not found" ]
        ]