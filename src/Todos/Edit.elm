module Todos.Edit exposing (..)

import Bootstrap.Button as Button
import Html exposing (..)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import Todos.Messages exposing (Msg(ChangeTitle, CreateOrPatch, ShowEditView))
import Todos.Models exposing (Todo, TodoEditView(..))


-- this module contains the todo edit view
-- it explains itself for the most part, it is just html


view : TodoEditView -> Html Msg
view ev =
    div []
        -- handle the different cases of the TodoEditView
        [ case ev of
            None ->
                Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick <| ShowEditView <| New "" ]
                    ]
                    [ text "Create New Todo" ]

            New title ->
                div []
                    [ h2 [] [ text "New Todo" ]
                    , editingInputs title
                    ]

            Editing { title } ->
                div []
                    [ h2 [] [ text <| "Editing Todo: " ++ title ]
                    , editingInputs title
                    ]
        ]



-- the "new" and "editing" forms are identical,
-- so they can be extracted into a separate component (editingInputs)


editingInputs : String -> Html Msg
editingInputs title =
    div []
        [ Button.button
            [ Button.outlinePrimary
            , Button.attrs [ onClick <| ShowEditView None ]
            ]
            [ text "Back" ]
        , input
            [ value title
            , placeholder "Title"
            , onInput ChangeTitle
            ]
            []
        , Button.button
            [ Button.outlinePrimary
            , Button.attrs [ onClick CreateOrPatch ]
            ]
            [ text "Save" ]
        ]
