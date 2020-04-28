module Pages.Tag exposing (Tag, estimatedReadTime, encode, decoder)

import Json.Decode as D
import Json.Encode as E


-- Tag

type alias Tag =
  { title : String
  , author : String
  , content : String
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
    [ ("title", E.string Tag.title)
    , ("author", E.string Tag.author)
    , ("content", E.string Tag.content)
    ]

decoder : D.Decoder Tag
decoder =
  D.map3 Tag
    (D.field "title" D.string)
    (D.field "author" D.string)
    (D.field "content" D.string)