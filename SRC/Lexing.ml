(*Creating variant of type token*)
type token = Verb of string | Noun of string | Question of string;;



let is_found (word)(lst) = 
  List.mem(word)(lst)
;;
(*The cleaned & merged input is sent to this function*)
let lex lst verbs questions = 
  let rec helper lst = 
    match lst with
    |[] -> []
    |hd::tl -> if (is_found (hd)(verbs)) then Verb(hd)::helper tl (*If the element (Hd) is found in the list of verbs (dataset) then it has type Verb*)
    else if (is_found(hd)(questions)) then Question(hd)::helper tl (*If the element (Hd) is found in the list of question words then it has type Question*)
    else Noun(hd)::helper tl (*else it is a Noun*)
  in
  helper(lst)
;;
