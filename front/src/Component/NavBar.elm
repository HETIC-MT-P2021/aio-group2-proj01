module Component.NavBar exposing (view)

import Component.NavLink as NavLink exposing (NavLink(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Routes exposing (Route(..))


view : String -> Route -> Html msg
view navTitle activeRoute =
    let
        isActive : Route -> Bool
        isActive r =
            r == activeRoute
    in
    nav [ class "navbar navbar-expand-lg navbar-light bg-light" ]
        [ a [ class "navbar-brand", href "/" ]
        [ text "ElmBum" ]
        , button [ attribute "aria-controls" "navbarSupportedContent", attribute "aria-expanded" "false", attribute "aria-label" "Toggle navigation", class "navbar-toggler", attribute "data-target" "#navbarSupportedContent", attribute "data-toggle" "collapse", type_ "button" ]
            [ span [ class "navbar-toggler-icon" ]
                []
            ]
        , div [ class "collapse navbar-collapse", id "navbarSupportedContent" ]
            [ ul [ class "navbar-nav mr-auto" ] <|
                    List.map NavLink.view
                    [ NavLink "Home" "/" (isActive Home)
                    , NavLink "Categories" "/category" (isActive Categories)
                    , NavLink "Tag" "/tag" (isActive Tag)
                    , NavLink "Image" "/image" (isActive Image)
                    ]
            ]
        ]
    