module Page.Category exposing (Msg, Model, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)


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
        [ h1 [] [ text <| "Category " ++ String.fromInt model.id ],
        div [ class "card" ]
            [ div [ class "card-body" ]
                [ h5 [ class "card-title" ]
                    [ text "TestCategoryName1" ]
                , p [ class "card-text" ]
                    [ text "TestCategoryDesc1" ]
                , a [ class "btn btn-primary", href "#", attribute "style" "margin-right:5px;" ]
                    [ text "Modifier" ]
                , a [ class "btn btn-primary", href "#", attribute "style" "margin-left:5px;" ]
                    [ text "Supprimer" ]
                ]
            ]
        ]