module Pages.Image exposing (Image, estimatedReadTime, encode, decoder)

import Json.Decode as D
import Json.Encode as E


-- Image

type alias Image =
  { title : String
  , author : String
  , content : String
  }


-- READ TIME

estimatedReadTime : Image -> Float
estimatedReadTime Image =
  toFloat (wordCount Image) / 220

wordCount : Image -> Int
wordCount Image =
  List.length (String.words Image.content)


-- JSON

encode : Image -> E.Value
encode Image =
  E.object
    [ ("title", E.string Image.title)
    , ("author", E.string Image.author)
    , ("content", E.string Image.content)
    ]

decoder : D.Decoder Image
decoder =
  D.map3 Image
    (D.field "title" D.string)
    (D.field "author" D.string)
    (D.field "content" D.string)