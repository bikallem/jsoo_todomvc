open Js_of_ocaml_tyxml.Tyxml_js
open Js_of_ocaml

let todo_app = Html5.(section ~a:[a_class ["todoapp"]] [])

let info_footer =
  Html5.(
    footer
      ~a:[a_class ["info"]]
      [ p [txt "Double click to edit a todo"]
      ; p
          [ txt "Written by "
          ; a ~a:[a_href "http://github.com/bikallem/"] [txt "Bikal Lem"] ]
      ; p [txt "Part of "; a ~a:[a_href "http://todomvc.com"] [txt "TodoMVC"]]
      ])

let main _ =
  Firebug.console##log info_footer ;
  (* let now = new%js Js.date_now in *)
  (* let date = now##toString in *)
  (* let s = Js.to_string date ^ " : Hello world!" in *)
  (* let html = Html5.(div [txt s]) in *)
  let app = Dom_html.getElementById "app" in
  Dom.appendChild app (To_dom.of_section todo_app) ;
  Dom.appendChild app (To_dom.of_footer info_footer) ;
  Js.bool true

let () =
  let onload_handler = Dom.handler main in
  Dom_html.window##.onload := onload_handler
