module Content exposing
    ( Content(..)
    , Msg
    , Model
    , init
    , initHomePage
    , initCategoriesPage
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
import Page.Categories as CategoriesPage
import Page.Category as CategoryPage
import Page.Tag as TagPage
import Page.Image as ImagePage
import Page.NotFound as NotFoundPage


type Content
    = ContentHome HomePage.Model
    | ContentCategories CategoriesPage.Model
    | ContentCategory Int CategoryPage.Model
    | ContentTag TagPage.Model
    | ContentImage ImagePage.Model
    | ContentNotFound


type Msg
    = HomePageMsg HomePage.Msg
    | CategoriesPageMsg CategoriesPage.Msg
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


initCategoriesPage : Model -> Model
initCategoriesPage model =
    { model | content = ContentCategories CategoriesPage.init }


initCategoryPage : Int -> Model -> Model
initCategoryPage id model =
    { model | content = ContentCategory id (CategoryPage.init id) }


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
        
        CategoriesPageMsg subMsg ->
            case model.content of
                ContentCategories m ->
                    let
                        (updated, subCmd) =
                            CategoriesPage.update subMsg m
                    in
                    ( { model | content = ContentCategories updated }
                    , Cmd.map CategoriesPageMsg subCmd
                    )

                _ ->
                    (model, Cmd.none)

        CategoryPageMsg subMsg ->
            case model.content of
                ContentCategory id m ->
                    let
                        (updated, subCmd) =
                            CategoryPage.update subMsg m
                    in
                    ( { model | content = ContentCategory id updated }
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

            ContentCategories m ->
                Html.map CategoriesPageMsg <|
                    CategoriesPage.view m

            ContentCategory id m ->
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