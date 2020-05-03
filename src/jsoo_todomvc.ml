open Js_of_ocaml_tyxml.Tyxml_js
open Js_of_ocaml

let new_todo : [> Html_types.header ] Html5.elt =
  Html5.(
    header
      ~a:[ a_class [ "header" ] ]
      [ h1 [ txt "todos" ]
      ; input
          ~a:
            [ a_class [ "new-todo" ]
            ; a_placeholder "What needs to be done?"
            ; a_autofocus ()
            ]
          ()
      ])

let main_section : Todo.t list -> [> Html_types.section ] Html5.elt =
 fun todos ->
  let open Html5 in
  let todo_ul = ul ~a:[ a_class [ "todo-list" ] ] @@ List.map Todo.render todos in
  let toggle_all_chkbox =
    input ~a:[ a_id "toggle-all"; a_class [ "toggle-all" ]; a_input_type `Checkbox ] ()
  in
  let toggle_all_lbl =
    label ~a:[ a_label_for "toggle-all" ] [ txt "Mark all as complete" ]
  in
  let visibility = if List.length todos > 0 then "" else "display:none" in
  section
    ~a:[ a_class [ "main" ]; a_style visibility ]
    [ toggle_all_chkbox; toggle_all_lbl; todo_ul; Footer.render todos ]

let info_footer =
  Html5.(
    footer
      ~a:[ a_class [ "info" ] ]
      [ p [ txt "Double click to edit a todo" ]
      ; p
          [ txt "Written by "
          ; a ~a:[ a_href "http://github.com/bikallem/" ] [ txt "Bikal Lem" ]
          ]
      ; p [ txt "Part of "; a ~a:[ a_href "http://todomvc.com" ] [ txt "TodoMVC" ] ]
      ])

let main _ =
  Firebug.console##log info_footer;
  let appElem = Dom_html.getElementById "app" in
  let todos =
    [ true, "Buy a unicorn"; false, "Eat haagen daz ice-cream, yummy!" ]
    |> List.map (fun (completed, todo) -> Todo.create ~completed todo)
  in
  let todo_app =
    Html5.(section ~a:[ a_class [ "todoapp" ] ] [ new_todo; main_section todos ])
  in
  Dom.appendChild appElem (To_dom.of_section todo_app);
  Dom.appendChild appElem (To_dom.of_footer info_footer);
  Js.bool true

let () =
  let onload_handler = Dom.handler main in
  Dom_html.window##.onload := onload_handler
