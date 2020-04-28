module Pages.Tag exposing (Tag, estimatedReadTime, encode, decoder)

import Json.Decode as D
import Json.Encode as E


-- Tag

type alias Tag =
  { id : Int
  , name : String
  }


-- READ TIME

estimatedReadTime : Tag -> Float
estimatedReadTime Tag =
  toFloat (wordCount Tag) / 220

wordCount : Tag -> Int
wordCount Tag =
  List.length (String.words Tag.content)


-- JSON

encode : Tag -> E.Value
encode Tag =
  E.object
    [ ("id", E.int Tag.id)
    , ("name", E.string Tag.name)
    ]

decoder : D.Decoder Tag
decoder =
  D.map3 Tag
    (D.field "id" D.int)
    (D.field "name" D.string)