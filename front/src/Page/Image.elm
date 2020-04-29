module Page.Image exposing (Msg, Model, init, update, view)

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
    [ h1 [] [ text <| "All images" ],
        table [ class "table table-striped" ]
            [ thead []
                [ tr []
                    [ th [ scope "col" ]
                        [ text "#" ]
                    , th [ scope "col" ]
                        [ text "Description" ]
                    , th [ scope "col" ]
                        [ text "Categorie" ]
                    , th [ scope "col" ]
                        [ text "URL" ]
                    , th [ scope "col" ]
                        [ text "Tags" ]
                    , th [ scope "col" ]
                        [ text "Date de création" ]
                    , th [ scope "col" ]
                        [ text "Action" ]
                    ]
                ]
            , tbody []
                [ tr []
                    [ th [ scope "row" ]
                        [ text "1" ]
                    , td []
                        [ text "TestImageDesc1" ]
                    , td []
                        [ text "TestImageCategoryDesc1" ]
                    , td []
                        [ a [ href "http://localhost:1323/picture/d41d8cd98f00b204e9800998ecf8427e.test2.png" ]
                            [ text "Lien " ]
                        ]
                    , td []
                        [ text "TestTagName1, TestTagName2" ]
                    , td []
                        [ text "2020-04-25T15:38:42.351144Z" ]
                    , td []
                        [ a [ href "cateogry/1" ]
                            [ text "Voir " ]
                        ]
                    ]
                , tr []
                    [ th [ scope "row" ]
                        [ text "2" ]
                    , td []
                        [ text "TestImageDesc2" ]
                    , td []
                        [ text "TestImageCategoryDesc2" ]
                    , td []
                        [ a [ href "http://localhost:1323/picture/d41d8cd98f00b204e9800998ecf8427e.test2.png" ]
                            [ text "Lien " ]
                        ]
                    , td []
                        [ text "TestTagName3, TestTagName2" ]
                    , td []
                        [ text "2020-04-25T15:38:42.351144Z" ]
                    , td []
                        [ a [ href "cateogry/1" ]
                            [ text "Voir " ]
                        ]
                    ]
                , tr []
                    [ th [ scope "row" ]
                        [ text "3" ]
                    , td []
                        [ text "TestImageDesc3" ]
                    , td []
                        [ text "TestImageCategoryDesc3" ]
                    , td []
                        [ a [ href "http://localhost:1323/picture/d41d8cd98f00b204e9800998ecf8427e.test2.png" ]
                            [ text "Lien " ]
                        ]
                    , td []
                        [ text "TestTagName1" ]
                    , td []
                        [ text "2020-04-25T15:38:42.351144Z" ]
                    , td []
                        [ a [ href "cateogry/1" ]
                            [ text "Voir " ]
                        ]
                    ]
                ]
            ]
    ]