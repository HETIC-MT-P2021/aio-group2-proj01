module Main exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Navigation exposing (Key)
import Html exposing (div, main_)
import Html.Attributes exposing (class)
import Routes exposing (Route(..), parseUrl)
import Url exposing (Url)
import Content


---- MODEL ----

type alias Model =
    { route : Route
    , navigationKey : Key
    , content : Content.Model
    }


init : flags -> Url -> Key -> ( Model, Cmd Msg )
init _ initialUrl navigationKey =
    let
        initialRoute = parseUrl initialUrl
    in
    ( { route = initialRoute
      , navigationKey = navigationKey
      , content = setContent initialRoute Content.init
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = OnUrlRequest UrlRequest
    | OnUrlChange Url
    | ContentMsg Content.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUrlChange newUrl ->
            let
                newRoute = parseUrl newUrl
            in
            ( { model
                | route = newRoute
                , content = setContent newRoute model.content
                }
            , Cmd.none
            )

        OnUrlRequest urlRequest ->
            case urlRequest of
                Internal internUrl ->
                    ( model
                    , internUrl
                        |> Url.toString
                        |> Navigation.pushUrl model.navigationKey
                    )

                External extUrl ->
                    ( model, Navigation.load extUrl )
        
        ContentMsg subMsg ->
            let
                (updated, subCmd) =
                    Content.update subMsg model.content
            in
            ( { model | content = updated }
            , Cmd.map ContentMsg subCmd
            )


setContent : Route -> Content.Model -> Content.Model
setContent route =
    case route of
        Home ->
            Content.initHomePage

        Category ->
            Content.initCategoryPage

        Tag ->
            Content.initTagPage

        Image ->
            Content.initImagePage

        NotFound ->
            Content.initNotFoundPage 



---- VIEW ----


view : Model -> Document Msg
view model =
    { title = "ElmBum"
    , body =
        [ div
            [ class "app" ]
            [ main_ []
                [ Html.map ContentMsg <|
                    Content.view model.content
                ]
            ]
        ]
    }    



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }
