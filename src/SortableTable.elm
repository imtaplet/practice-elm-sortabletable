module SortableTable exposing (Model, Msg, init, update, view)

import Html exposing (Html, table, tbody, td, text, th, thead, tr)
import Html.Events exposing (onClick)


type alias Model =
    { sortColumn : Maybe String
    , reversed : Bool
    , columns : List String
    }


type Msg
    = ClickColumn (Maybe String)


init : Model
init =
    Model Nothing False [ "書籍名" ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        ClickColumn columnName ->
            { model
                | sortColumn = columnName
                , reversed =
                    not model.reversed
            }


view : Model -> List String -> Html Msg
view model items =
    let
        reversedItems =
            if model.reversed then
                List.reverse items

            else
                items
    in
    table
        [ onClick (ClickColumn Nothing)
        ]
        [ thead [] (List.map viewColumn model.columns)
        , tbody [] (List.map viewRow reversedItems)
        ]


viewColumn : String -> Html Msg
viewColumn item =
    tr []
        [ viewHeader item
        ]


viewHeader : String -> Html Msg
viewHeader item =
    th []
        [ text item
        ]


viewRow : String -> Html Msg
viewRow item =
    tr []
        [ viewCell item
        ]


viewCell : String -> Html Msg
viewCell item =
    td []
        [ text item
        ]
