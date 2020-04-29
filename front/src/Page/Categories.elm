module Page.Categories exposing (Msg, Model, init, update, view)

import Html exposing (Html, section, h1, div, a, text)
import Html.Attributes exposing (href)


---- MODEL ----


type alias Model =
    {}


init : Model
init =
    {}



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
   ( model, Cmd.none )


---- VIEW ----


view : Model -> Html Msg
view model =
    section []
        [ h1 [] [ text <| "All categories" ]
        , a [ href "category/1"] [ text <| "Category 1" ]
        , a [ href "category/2"] [ text <| "Category 2" ]
        , a [ href "category/3"] [ text <| "Category 3" ]
        ]