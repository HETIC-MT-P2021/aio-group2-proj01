module Page.Categories exposing (Msg, Model, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode 
    exposing
    ( Decoder
    , int
    , list
    , string
    , map3
    , field
    )


---- MODEL ----


type alias Category =
    { id_category : Int
    , name : String
    , description : String
    }

type alias Model =
    { data : List Category
    , errorMessage : Maybe String
    }


init : Model
init =
    { data = []
      , errorMessage = Nothing
      }



---- UPDATE ----


type Msg
    = SendHttpRequest
    | DataReceived (Result Http.Error (List Category))



categoriesDecoder : Decoder Category
categoriesDecoder =
    map3 Category
        (field "id_category" int)
        (field "name" string)
        (field "description" string)



httpCommand : Cmd Msg
httpCommand =
    Http.get
        { url = "http://localhost:1323/category"
        , expect = Http.expectJson DataReceived (Json.Decode.list categoriesDecoder)
        }



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
   case msg of
        SendHttpRequest ->
            ( model, httpCommand )
        
        DataReceived (Ok data) ->
            ( { model
            | data = data
            , errorMessage = Nothing
            }, Cmd.none )

        DataReceived (Err httpError) ->
            ( { model
                | errorMessage = Just (buildErrorMessage httpError)
              }
            , Cmd.none
            )

buildErrorMessage : Http.Error -> String
buildErrorMessage httpError =
    case httpError of
        Http.BadUrl message ->
            message

        Http.Timeout ->
            "Server is taking too long to respond. Please try again later."

        Http.NetworkError ->
            "Unable to reach server."

        Http.BadStatus statusCode ->
            "Request failed with status code: " ++ String.fromInt statusCode

        Http.BadBody message ->
            message



---- VIEW ----


view : Model -> Html Msg
view model =
    section []
        [ h1 [] [ text <| "All categories" ]
        , button [ onClick SendHttpRequest ]
            [ text "Get data from server" ]
        , viewCategoriesOrError model
        ]

viewCategoriesOrError : Model -> Html Msg
viewCategoriesOrError model =
    case model.errorMessage of
        Just message ->
            viewError message

        Nothing ->
            viewCategories model.data

viewError : String -> Html Msg
viewError errorMessage =
    let
        errorHeading =
            "Couldn't fetch categories at this time."
    in
    div []
        [ h3 [] [ text errorHeading ]
        , text ("Error: " ++ errorMessage)
        ]


viewCategories : List Category -> Html Msg
viewCategories data =
    div []
        [ table [ class "table table-striped" ]
            ([ viewTableHeader ] ++ List.map viewCategory data)
        ]

viewTableHeader : Html Msg
viewTableHeader =
    tr []
        [ th [ scope "col" ] [ text "#" ]
        , th [ scope "col" ] [ text "Nom" ]
        , th [ scope "col" ] [ text "Description" ]
        , th [ scope "col" ] [ text "Action" ]
        ]

viewCategory : Category -> Html Msg
viewCategory data =
    tr []
        [ td [] [ text (String.fromInt data.id_category) ]
        , td [] [ text data.name ]
        , td [] [ text data.description ]
        , td [] [ a [ href <| "category/" ++ (String.fromInt data.id_category) ]
                    [ text "Voir" ]
                ]
        ]