module Main exposing (main)

import Browser exposing (sandbox)
import Dict
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
    { books : List (Dict.Dict String String)
    , tableState : SortableTable.Model
    }


type Msg
    = UpdateTable SortableTable.Msg


book : String -> String -> Dict.Dict String String
book name price =
    [ ( "書籍名", name )
    , ( "価格", price )
    ]
        |> Dict.fromList


init : Model
init =
    { books =
        [ book "基礎からわかる Elm" "2,893円"
        , book "一兆ドルコーチ" "1,870円"
        ]
    , tableState = SortableTable.init [ "書籍名", "価格" ]
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
