module View exposing (..)

import Bootstrap.Alert as Alert
import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Html exposing (..)
import Html.Attributes exposing (class, href, style, target)
import Messages exposing (Msg(TodosMsg))
import Models exposing (Model)
import Todos.Edit
import Todos.List


-- this is our "root" view. the entire appearance of our application
-- is derived here from the app state (model)


view : Model -> Html Msg
view model =
    div []
        [ siteHeader

        -- render the todos edit and list sub-views using pars of the model,
        -- then "tag" outgoing messages with TodosMsg
        , Html.map TodosMsg <| Todos.Edit.view model.todoEditView
        , br [] []
        , Html.map TodosMsg <| Todos.List.view model.todos
        ]


siteHeader : Html Msg
siteHeader =
    header []
        [ h1 [] [ text "Elm Todos" ]
        , p []
            [ text "Built with "
            , atb "http://elm-lang.org" "Elm"
            , text " ♥"
            ]
        , p []
            [ text "Created by Andrew Suzuki"
            , pipeDivider
            , atb "https://github.com/andrewsuzuki" "github"
            , pipeDivider
            , atb "https://github.com/andrewsuzuki/elm-todomvc-with-api" "source"
            ]
        ]


pipeDivider : Html Msg
pipeDivider =
    text " | "


atb : String -> String -> Html Msg
atb url title =
    a
        [ href url
        , target "_blank"
        ]
        [ text title ]
