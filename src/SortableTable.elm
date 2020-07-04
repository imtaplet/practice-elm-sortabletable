module SortableTable exposing (Model, Msg, init, update, view)

import Dict
import Html exposing (Html, table, tbody, td, text, th, thead, tr)
import Html.Events exposing (onClick)


type Model
    = Model Internal


type alias Internal =
    { sortColumn : Maybe String
    , reversed : Bool
    , columns : List String
    }


type Msg
    = ClickColumn (Maybe String)


init : List String -> Model
init columns =
    Model
        { sortColumn = Nothing
        , reversed = False
        , columns = columns
        }


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        ClickColumn columnName ->
            if model.sortColumn == columnName then
                { model
                    | reversed = not model.reversed
                }
                    |> Model

            else
                { model
                    | reversed = False
                    , sortColumn = columnName
                }
                    |> Model


view : Model -> List (Dict.Dict String String) -> Html Msg
view (Model model) items =
    let
        sortedItems =
            case model.sortColumn of
                Just column ->
                    items
                        |> List.sortBy
                            (\item ->
                                item
                                    |> Dict.get column
                                    |> Maybe.withDefault ""
                            )

                Nothing ->
                    items

        reversedItems =
            if model.reversed then
                sortedItems
                    |> List.reverse

            else
                sortedItems
    in
    table
        []
        [ thead [] [ viewColumn model.columns ]
        , tbody [] (List.map viewRow reversedItems)
        ]


viewColumn : List String -> Html Msg
viewColumn columns =
    tr []
        (columns |> List.map viewHeader)


viewHeader : String -> Html Msg
viewHeader item =
    th [ onClick (ClickColumn (Just item)) ]
        [ text item
        ]


viewRow : Dict.Dict String String -> Html Msg
viewRow rows =
    tr []
        (rows |> Dict.values |> List.map viewCell)


viewCell : String -> Html Msg
viewCell item =
    td []
        [ text item
        ]
