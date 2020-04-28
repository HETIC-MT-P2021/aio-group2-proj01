module Content exposing
    ( Content(..)
    , Msg
    , Model
    , init
    , initHomePage
    , initCategoryPage
    , initTagPage
    , initImagePage
    , initNotFoundPage
    , update
    , view
    )

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Page.Home as HomePage
import Page.Category as CategoryPage
import Page.Tag as TagPage
import Page.Image as ImagePage
import Page.NotFound as NotFoundPage


type Content
    = ContentHome HomePage.Model
    | ContentCategory CategoryPage.Model
    | ContentTag TagPage.Model
    | ContentImage ImagePage.Model
    | ContentNotFound


type Msg
    = HomePageMsg HomePage.Msg
    | CategoryPageMsg CategoryPage.Msg
    | TagPageMsg TagPage.Msg
    | ImagePageMsg ImagePage.Msg


type alias Model =
    { content : Content
    , anyOtherProperty : String
    }


init : Model
init =
    { content = ContentHome HomePage.init
    , anyOtherProperty = "add here"
    }


initHomePage : Model -> Model
initHomePage model =
    { model | content = ContentHome HomePage.init }


initCategoryPage : Model -> Model
initCategoryPage model =
    { model | content = ContentCategory CategoryPage.init }


initTagPage : Model -> Model
initTagPage model =
    { model | content = ContentTag TagPage.init }


initImagePage : Model -> Model
initImagePage model =
    { model | content = ContentImage ImagePage.init }


initNotFoundPage : Model -> Model
initNotFoundPage model =
    { model |  content = ContentNotFound }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        HomePageMsg subMsg ->
            case model.content of
                ContentHome m ->
                    let
                        (updated, subCmd) =
                            HomePage.update subMsg m
                    in
                    ( { model | content = ContentHome updated }
                    , Cmd.map HomePageMsg subCmd
                    )

                _ ->
                    (model, Cmd.none)
        
        CategoryPageMsg subMsg ->
            case model.content of
                ContentCategory m ->
                    let
                        (updated, subCmd) =
                            CategoryPage.update subMsg m
                    in
                    ( { model | content = ContentCategory updated }
                    , Cmd.map CategoryPageMsg subCmd
                    )

                _ ->
                    (model, Cmd.none)

        TagPageMsg subMsg ->
            case model.content of
                ContentTag m ->
                    let
                        (updated, subCmd) =
                            TagPage.update subMsg m
                    in
                    ( { model | content = ContentTag updated }
                    , Cmd.map TagPageMsg subCmd
                    )

                _ ->
                    (model, Cmd.none)

        ImagePageMsg subMsg ->
            case model.content of
                ContentImage m ->
                    let
                        (updated, subCmd) =
                            ImagePage.update subMsg m
                    in
                    ( { model | content = ContentImage updated }
                    , Cmd.map ImagePageMsg subCmd
                    )

                _ ->
                    (model, Cmd.none)


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ case model.content of
            ContentHome m ->
                Html.map HomePageMsg <|
                    HomePage.view m

            ContentCategory m ->
                Html.map CategoryPageMsg <|
                    CategoryPage.view m

            ContentTag m ->
                Html.map TagPageMsg <|
                    TagPage.view m

            ContentImage m ->
                Html.map ImagePageMsg <|
                    ImagePage.view m
            ContentNotFound ->
                NotFoundPage.view
        ]