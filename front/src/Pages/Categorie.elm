module Pages.Categorie exposing (Categorie, estimatedReadTime, encode, decoder)

import Json.Decode as D
import Json.Encode as E


-- Categorie

type alias Categorie =
  { id : Int
  , name : String
  , description : String
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
    [ ("id", E.int Categorie.id)
    , ("name", E.string Categorie.name)
    , ("description", E.string Categorie.description)
    ]

decoder : D.Decoder Categorie
decoder =
  D.map3 Categorie
    (D.field "id" D.int)
    (D.field "name" D.string)
    (D.field "description" D.string)