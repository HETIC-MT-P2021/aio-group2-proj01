module Pages.Categorie exposing (Categorie, estimatedReadTime, encode, decoder)

import Json.Decode as D
import Json.Encode as E


-- Categorie

type alias Categorie =
  { title : String
  , author : String
  , content : String
  }


-- READ TIME

estimatedReadTime : Categorie -> Float
estimatedReadTime Categorie =
  toFloat (wordCount Categorie) / 220

wordCount : Categorie -> Int
wordCount Categorie =
  List.length (String.words Categorie.content)


-- JSON

encode : Categorie -> E.Value
encode Categorie =
  E.object
    [ ("title", E.string Categorie.title)
    , ("author", E.string Categorie.author)
    , ("content", E.string Categorie.content)
    ]

decoder : D.Decoder Categorie
decoder =
  D.map3 Categorie
    (D.field "title" D.string)
    (D.field "author" D.string)
    (D.field "content" D.string)