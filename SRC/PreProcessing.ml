 open Map
 open Random
 module StringMap=Map.Make(String);;
 Random.self_init ();;  
 #load "str.cma";;


 (*This function reads takes the file name as a parameter and converts it into a list of strings*)
 let read_file filename = 
  let lines = ref [] in
  let x = open_in filename in
  try
    while true; do
      lines := input_line x :: !lines
    done; !lines
  with End_of_file ->
    close_in x;
    (*Reversing the list so its end result is in order *)
    List.rev !lines ;;

(*Takes lst & map as parameters and stores the head of the list as key and the tail as value*)
let store_list_in_map lst map=
match lst with
| hd::tl -> StringMap.add (hd)(tl)(map)
| _-> map (*In case the list is empty*)
;;
 
let  splitstring lst separator= 
  let rec helper indx  =
  match indx with
  (*Stopping when the indx passed is outside the range of strs in a list*)
  (*If not it seperates the string to a list of strings when it meets the semicolon*)
  |indx when indx = List.length(lst) ->[]
  |_->String.split_on_char(separator)(List.nth(lst)(indx)) :: helper (indx+1)
in 
(*Calling the helper function with the first element of the list*)
helper 0
;;

(*passes each list in the lst of lsts to the function that stores in the map*)
let rec divide_lst_of_lsts lst_of_lsts map= 
  match lst_of_lsts with
  |[] -> map
  |hd::tl -> divide_lst_of_lsts tl (store_list_in_map hd map)
;;

(*Reads a file and stores it in a map*)
let preprocess_file (file) = 
  let my_map = StringMap.empty in
  let lst = read_file(file) in
  let lst_of_lsts = splitstring (lst)(';') in
  divide_lst_of_lsts(lst_of_lsts)(my_map)
;;