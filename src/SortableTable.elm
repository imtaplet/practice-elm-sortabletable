module SortableTable exposing (Model, Msg, init, update, view)

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


init : Model
init =
    Model
        { sortColumn = Nothing
        , reversed = False
        , columns = [ "書籍名", "価格" ]
        }


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        ClickColumn columnName ->
            { model
                | sortColumn = columnName
                , reversed =
                    not model.reversed
            }
                |> Model


view : Model -> List (List String) -> Html Msg
view (Model model) items =
    table
        [ onClick (ClickColumn Nothing)
        ]
        [ thead [] [ viewColumn model.columns ]
        , tbody [] (List.map viewRow items)
        ]


viewColumn : List String -> Html Msg
viewColumn columns =
    tr []
        (columns |> List.map viewHeader)


viewHeader : String -> Html Msg
viewHeader item =
    th []
        [ text item
        ]


viewRow : List String -> Html Msg
viewRow rows =
    tr []
        (rows |> List.map viewCell)


viewCell : String -> Html Msg
viewCell item =
    td []
        [ text item
        ]
