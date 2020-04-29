module Component.NavBar exposing (view)

import Component.NavLink as NavLink exposing (NavLink(..))
import Html exposing (Html, nav, div, text)
import Html.Attributes exposing (class)
import Routes exposing (Route(..))


view : String -> Route -> Html msg
view navTitle activeRoute =
    let
        isActive : Route -> Bool
        isActive r =
            r == activeRoute
    in
    nav [ class "nav-bar" ]
        [ div [ class "title" ]
            [ text navTitle
            ]
        , div [ class "links" ] <|
            List.map NavLink.view
                [ NavLink "Home" "/" (isActive Home)
                , NavLink "Categories" "/category" (isActive Categories)
                , NavLink "Tag" "/tag" (isActive Tag)
                , NavLink "Image" "/image" (isActive Image)
                ]
        ]