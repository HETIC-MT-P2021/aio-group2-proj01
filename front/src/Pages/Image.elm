module Pages.Image exposing (Image, estimatedReadTime, encode, decoder)

import Json.Decode as D
import Json.Encode as E


-- Image

type alias Image =
  { id : Int
  , description : String
  , url : String
  , created_at : Date
  , tag : String
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
    [ ("id", E.int Image.id)
    , ("description", E.string Image.description)
    , ("url", E.string Image.url)
    , ("created_at", E.date Image.created_at)
    , ("tag", E.date Image.tag)
    ]

decoder : D.Decoder Image
decoder =
  D.map3 Image
    (D.field "id" D.int)
    (D.field "description" D.string)
    (D.field "url" D.string)
    (D.field "created_at" D.date)
    (D.field "tag" D.string)