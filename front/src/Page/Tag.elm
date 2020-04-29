module Page.Tag exposing (Msg, Model, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)


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
        [ h1 [] [ text <| "All tags" ],
        table [ class "table table-striped" ]
            [ thead []
                [ tr []
                    [ th [ scope "col" ]
                        [ text "#" ]
                    , th [ scope "col" ]
                        [ text "Nom" ]
                    , th [ scope "col" ]
                        [ text "Action" ]
                    ]
                ]
            , tbody []
                [ tr []
                    [ th [ scope "row" ]
                        [ text "1" ]
                    , td []
                        [ text "TestTagName1" ]
                    , td []
                        [ a [ href "tag/1" ]
                            [ text "Voir " ]
                        ]
                    ]
                , tr []
                    [ th [ scope "row" ]
                        [ text "2" ]
                    , td []
                        [ text "TestTagName2" ]
                    , td []
                        [ a [ href "tag/2" ]
                            [ text "Voir " ]
                        ]
                    ]
                , tr []
                    [ th [ scope "row" ]
                        [ text "3" ]
                    , td []
                        [ text "TestTagName3" ]
                    , td []
                        [ a [ href "tag/3" ]
                            [ text "Voir " ]
                        ]
                    ]
                ]
            ]
        ]