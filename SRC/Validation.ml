#use "Lexing.ml"

(*This function is a finite state machine that validates the user input according to our grammar which is :
 1. Question+Noun+Verb
 2. Question+Verb+Noun
 3. Verb+Noun
 4. Question+verb

 takes the list of tokens and an integer n which indicates the end of my valid sub-list as arguments
inside it is a helper function which have 4 parameters one indicates the state in the finite state machine, the list
whether we are in a valid state ot not and the end index to mark the end of the longest valid sublist
*)
let rec state_machine (lst)(n) = 

  let rec helper (state)(lst)(valid)(end_indx) = 

  match lst with

  |[]->(valid,end_indx-1)(*the -1 is because when we reach a valid state but not a final one and the list is empty an extra +1 is added*)

  |Question(_)::tl -> if state = 0 then helper (1)(tl)(0)(end_indx+1)
  else (valid,end_indx)

  |Verb(_)::tl -> if state = 0 then helper(2)(tl)(0)(end_indx+1) 
  else if state = 1  then helper(2)(tl)(1)(end_indx+1)(*Q v is valid*)
  else if state = 4 then 1,end_indx
  else (valid,end_indx)

  |Noun(_)::tl -> if state = 1 then helper(4)(tl)(1)(end_indx+1)
  (* else if state = 2 then 1,end_indx *)
  (* else (valid,end_indx) *)
  else helper(4)(tl)(1)(end_indx+1)

in helper (0)(lst)(0)(n)
;;

(*Longest_valid_sublist is a function that takes a list and an integer n
   n: is the variable that marks the start of the sublist
   and returns a pair of start and end indices of the longest valid sublist
   in case there is no valid sublists, it returns (-1,-1)*)
let rec longest_valid_sublist lst n = 
  match lst with
  |[]-> (-1,-1)
  |hd::tl -> let (n1,n2) = state_machine(lst)(n)  in if n1 = 1 then (n,n2)
  else longest_valid_sublist(tl)(n+1)
;;  


(*Slice_list is a function that takes a list and two indices x,y indicating 
   the start and end indices for slicing the list and indx which is used to know the current location in the list.
   It returns a sub-list starting at index x and ending at index y*)
let rec slice_list lst x y indx = 
  match lst with
  |[]->[]
  |hd::tl when (indx >= x && indx <= y) -> hd::(slice_list(tl)(x)(y)(indx+1))
  |hd::tl -> (slice_list (tl) (x) (y) (indx+1))
;;