module Todos.List exposing (..)

import Bootstrap.Alert as Alert
import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Table as Table
import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Todos.Messages exposing (Msg(Complete, Delete, DeleteCompleted, Patch, Revert, ShowEditView))
import Todos.Models exposing (Todo, TodoEditView(Editing))


-- this module contains the todo list view
-- it explains itself for the most part, it is just html
-- just some common styles for table cells (th and td)


cellStyle : List ( String, String )
cellStyle =
    [ ( "textAlign", "left" )
    , ( "padding", "10px" )
    ]



-- make a cell (th or td) with the pre-set style attribute


cell el children =
    el [ style cellStyle ] children



-- the main view here is a table with headers and body rows for each todo


view : List Todo -> Html Msg
view todos =
    div []
        [ Table.table
            { options = [ Table.bordered ]
            , thead =
                Table.simpleThead
                    [ Table.th [] [ text "Id" ]
                    , Table.th [] [ text "Title" ]
                    , Table.th [] [ text "Completed?" ]
                    , Table.th [] [ text "Actions" ]
                    ]
            , tbody =
                Table.tbody [] <| List.map todo2 <| todos
            }
        , footer
        ]



-- a single todo row


todo2 : Todo -> Table.Row Msg
todo2 t =
    let
        -- destructure our todo
        { id, title, completed } =
            t

        -- decide on some UI text/actions based on todo completed status
        ( completedText, buttonText, buttonMsg ) =
            if completed then
                ( "Yes", "Revert", Revert )
            else
                ( "No", "Done", Complete )
    in
    Table.tr []
        [ Table.td [] [ text <| toString id ]
        , Table.td [] [ text title ]
        , Table.td [] [ text completedText ]
        , Table.td []
            [ Button.button
                [ Button.primary
                , Button.attrs [ onClick <| buttonMsg t ]
                ]
                [ text buttonText ]
            , Button.button
                [ Button.info
                , Button.attrs [ onClick <| ShowEditView <| Editing t ]
                ]
                [ text "Edit" ]
            , Button.button
                [ Button.danger
                , Button.attrs [ onClick <| Delete t ]
                ]
                [ text "Delete" ]
            ]
        ]


todo : Todo -> Html Msg
todo t =
    let
        -- destructure our todo
        { id, title, completed } =
            t

        -- decide on some UI text/actions based on todo completed status
        ( completedText, buttonText, buttonMsg ) =
            if completed then
                ( "Yes", "Revert", Revert )
            else
                ( "No", "Done", Complete )
    in
    tr []
        [ cell td [ text <| toString id ]
        , cell td [ text title ]
        , cell td [ text completedText ]
        , cell td
            [ Button.button
                [ Button.primary
                , Button.attrs [ onClick <| buttonMsg t ]
                ]
                [ text buttonText ]
            , Button.button
                [ Button.info
                , Button.attrs [ onClick <| ShowEditView <| Editing t ]
                ]
                [ text "Edit" ]
            , Button.button
                [ Button.danger
                , Button.attrs [ onClick <| Delete t ]
                ]
                [ text "Delete" ]
            ]
        ]



-- footer


footer : Html Msg
footer =
    div []
        [ br [] []
        , Button.button
            [ Button.danger
            , Button.attrs [ onClick DeleteCompleted ]
            ]
            [ text "Clear Completed" ]
        ]
