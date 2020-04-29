module Page.Home exposing (Msg, Model, init, update, view)

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
        [ div [ class "jumbotron", attribute "style" "background-color:#FFF;" ]
            [ h1 [ class "display-4" ]
                [ text "Bienvenue sur ElmBum" ]
            , p [ class "lead" ]
                [ text "ElmBum est un album photo en ligne développé en Go et ELM" ]
            , a [ href "https://goreportcard.com/report/github.com/HETIC-MT-P2021/aio-group2-proj01", attribute "style" "margin-right:10px;" ]
                [ img [ alt "Go Report Card", src "https://goreportcard.com/badge/github.com/HETIC-MT-P2021/aio-group2-proj01" ]
                    []
                ]
            , a [ href "https://godoc.org/github.com/HETIC-MT-P2021/aio-group2-proj01/back/router", attribute "style" "margin-right:10px;" ]
                [ img [ alt "GoDoc", src "https://godoc.org/github.com/HETIC-MT-P2021/aio-group2-proj01/back/router?status.svg" ]
                    []
                ]
            , a [ href "https://github.com/HETIC-MT-P2021/aio-group2-proj01/actions?query=workflow%3Areviewdog", attribute "style" "margin-right:10px;" ]
                [ img [ alt "reviewdog", src "https://github.com/HETIC-MT-P2021/aio-group2-proj01/workflows/reviewdog/badge.svg" ]
                    []
                ]
            , a [ href "https://github.com/HETIC-MT-P2021/aio-group2-proj01/blob/master/LICENSE", attribute "style" "margin-right:10px;" ]
                [ img [ alt "License: MIT", src "https://img.shields.io/badge/License-MIT-yellow.svg" ]
                    []
                , text "      "
                ]
                , table [ align "center" ]
                    [ tr []
                        [ td [ align "center" ]
                            [ a [ href "https://github.com/acauchois" ]
                                [ img [ src "https://github.com/acauchois.png", attribute "width" "150px;" ]
                                    []
                                , br []
                                    []
                                , b []
                                    [ text "Alexis Cauchois" ]
                                ]
                            ]
                        , td [ align "center" ]
                            [ a [ href "https://github.com/Akecel" ]
                                [ img [ src "https://github.com/Akecel.png", attribute "width" "150px;" ]
                                    []
                                , br []
                                    []
                                , b []
                                    [ text "Axel Rayer" ]
                                ]
                            ]
                        , td [ align "center" ]
                            [ a [ href "https://github.com/t-hugo" ]
                                [ img [ src "https://github.com/t-hugo.png", attribute "width" "150px;" ]
                                    []
                                , br []
                                    []
                                , b []
                                    [ text "Hugo Tinghino" ]
                                ]
                            ]
                        ]
                    ]
            , hr [ class "my-4" ]
                []
            , div [attribute "style" "width:50%;margin:auto;"]
                [ text "Vous pouvez retrouver le guide d'utilisation ainsi que toutes les documentations nécéssaires sur la page "
                , a [ href "https://github.com/HETIC-MT-P2021/aio-group2-proj01/" ]
                    [ text "GitHub" ]
                , text " du projet"
                ]
            ]
        ]