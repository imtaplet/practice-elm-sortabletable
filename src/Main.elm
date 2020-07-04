module Main exposing (main)

import Browser exposing (sandbox)
import Html exposing (Html)
import SortableTable


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { books : List (List String)
    , tableState : SortableTable.Model
    }


type Msg
    = UpdateTable SortableTable.Msg


init : Model
init =
    { books =
        [ [ "基礎からわかる Elm"
          , "2,893円"
          ]
        , [ "一兆ドルコーチ"
          , "1,870円"
          ]
        ]
    , tableState = SortableTable.init
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateTable tableMsg ->
            { model
                | tableState =
                    SortableTable.update tableMsg model.tableState
            }


view : Model -> Html Msg
view model =
    Html.map UpdateTable <|
        SortableTable.view model.tableState model.books
