open Map
module StringMap=Map.Make(String);;
#load "str.cma";;
(*Removes Punctuation*)
let remove_punctuation (str: string) : string =
  let punctuation = Str.regexp "[^a-zA-Z0-9]+" in
  Str.global_replace punctuation " " str
;;

(*Function that takes a list and filters it to remove elements found in stop words file and transforms it to lowercase*)
let clean_string s r = 
  List.filter(fun x-> not (List.mem (x)(r)))(String.split_on_char(' ')(String.lowercase_ascii( remove_punctuation s)))
;;
(*After Cleaning*)

let search_for_value (key)(value : string)(map) = 
  let vals_lst = StringMap.find key map in 
  if List.exists(fun x->x=value)(vals_lst) then true
  else  false
;;
(*Checks if the cleaned input list has any 2 words that can be merged together to get a more accurate meaning*)
(*If found, the 2 strings are concatenated and inserted inside a list as the cleaned & merged input*)
let rec merge lst map= 
  if lst = [] then []
  else
  let flag = StringMap.exists (fun key _ -> key = List.hd lst ) map in
  if flag = true then (*Element is present in Phrases file and might be concatenated with the next element if present*)
  match lst with
    |[]->[]
    |hd::hd2::tl when search_for_value (hd) (hd2) (map) = true->(hd^" "^hd2) :: merge tl map (*the next element can be concatenated with the previous element*)
    |hd::tl -> hd::merge tl map (*Next element can't be concatenated with previous element so gets inserted as is*)
  else (*Nothing can be concatenated so insert element as is*)
  match lst with
  |[] -> []
  |hd::tl -> hd:: merge tl map 
  ;;
