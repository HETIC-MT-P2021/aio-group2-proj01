module Page.Category exposing (Msg, Model, init, update, view)

import Html exposing (Html, section, h1, div, text)


---- MODEL ----


type alias Model =
    { id : Int }


init : Int -> Model
init id =
    { id = id
    }



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
        [ h1 [] [ text <| "Category #" ++ String.fromInt model.id ]
        ]