(* checks if the second string is contained in the first string *)
let contains s1 s2 =
  (* Str.regexp takes a string argument representing a regular expression pattern and returns a regular expression object*)
  let re = Str.regexp_string s2
  in
      (* returns true if found false otherwise *)
      try ignore (Str.search_forward re s1 0); true 
      with Not_found -> false
;;

(* a function that takes the user's cleaned and lexed input and a list of outputs*)
let generateOutput input lst_of_out = 
  (* helper function that checks if the input entered exists in the list and returns it's corresponding output as an option *)
  let rec helper indx=
    if indx >= List.length lst_of_out then None
    else
    let lst = (List.nth lst_of_out indx) in
    match lst with
    |[] -> None
    |hd::tl::[] when contains input hd = true ->  Some tl
    |hd:: tl -> helper (indx+1)
  in 
  helper 0;;

(* uses pattern matching to print whether the output exists in the list of outputs or not *)
let display_output result = 
match result with
|None -> print_endline "Sorry, I don't understand what you mean\nCould you please rephrase your question or check for typos"
|Some i -> print_endline i
;; 
