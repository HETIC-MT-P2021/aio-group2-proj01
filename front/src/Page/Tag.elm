module Page.Tag exposing (Msg, Model, init, update, view)

import Html exposing (Html, section, div, text)


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
        [ div []
            [ text "Welcome to the tag page." ]
        ]