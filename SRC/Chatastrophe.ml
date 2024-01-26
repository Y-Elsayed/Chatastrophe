#use "PreProcessing.ml"
#use "Cleaning.ml"
#use "Lexing.ml"
#use "Validation.ml"
#use "GenerateOutput.ml"
#use "HelpMenu.ml"
#load "str.cma";;

(*record to store the person's name*)
type person = {name:string};;


(*Preprocessing data*)

(*Container for the quesetions and their responses*)
let genout= read_file("GenerateOutput.csv");;
let lst_of_out = splitstring (genout) (';');;(*list of lists of strings*)

(*container for keywords and their responses*)
let keywords= read_file("Keywords.csv");;
let lst_of_key = splitstring (keywords) (';');;(*list of lists of strings*)

let verbs = read_file ("New_verbs.csv");;(*list of strings*)

let stop_words = read_file("stopwords.csv");;(*list of strings*)

let questions = ["why";"when";"which";"where";"how";"who";"what"];;(*list of question words*)

let phrases_map = StringMap.empty;;
let phrases_map = divide_lst_of_lsts(splitstring(read_file("Phrases.csv"))(';'))(phrases_map);;(*map*)



let main() = 
    (*Greeting the user at the beggining of the program and taking his name as input and storing it*)
    print_endline"Hello this is J.A.R.V.I.S, EUI's (Not so smart) chatbot";
    print_string"Please tell me your name (Mr/Ms): ";
    let usr_name = read_line() in
    let user = {name = String.lowercase_ascii(usr_name)} in
    print_string"How can I help you today ";print_endline user.name;

    (*Start of the actual chatbot*)
let rec chatbot() = 
    print_string">";
    let usr_inp = read_line() (*user input*)in 

    if (String.lowercase_ascii(usr_inp)) <> "bye" then(*if the user input is not bye it proceeds*)

        if (String.lowercase_ascii(usr_inp)) = "help" then let helpinput= displaymenu() in (*if the user input is "help" it displays a menu with the questions he can ask*)
            if helpinput <> " " then (*if the user did not enter 11 in the displaymenu function indicating that he chose an option from the menu*)
                display_output(generateOutput (helpinput)(lst_of_out));(*displays the output of his chosen option*)
                print_endline"";
                chatbot()(*recursive call to chatbot*)
                
        else(*if he did not input help*)
            let clean_inp = merge(clean_string(usr_inp)(stop_words))(phrases_map) in (*clean input*) 
            let tokenized_input = lex (clean_inp)(verbs)(questions) in (*Tokenized input*)
            let tup = longest_valid_sublist(tokenized_input)(0) in (*pair containing the start and end index of the valid sub-list*)

            if (fst tup) = -1 (*if cleaned input consists of one word*)
            then display_output(generateOutput (List.fold_right(fun str x-> str^" "^x) clean_inp "")(lst_of_key))(*will display output from the list of keywords*)
            else if (fst tup) <> (-1) then (*else if the cleaned input has more than one word and has a valid structure*)
                let final_inp = slice_list(clean_inp)(fst tup)(snd tup)(0) in(*sliced the list to get the valid sub-list*)
                display_output(generateOutput (List.fold_right(fun str x-> str^" "^x) final_inp "")(lst_of_out));(*displayed the output of the valid sub-list after concatenating it's elements into one string*)
                print_endline"";
            else
                print_endline"Invalid structure, please try again";(*if the first element in the pair is -1, this means that it is not a valid input*)

        chatbot()(*recursive call to chatbot*)

    else(*if the user input is bye*)
        match user.name with
        |"yassin" ->print_string"Thank you for visiting EUI\nBYE "; print_endline "Yassin Basha";
        |"malak" ->print_string"Thank you for visiting EUI\nBYE "; print_endline "Malooka";
        |"roba" ->print_string"Thank you for visiting EUI\nBYE "; print_endline "ابوووور";
        |"bebo" -> print_string"Thank you for visiting EUI\nBYE ";print_endline "Ya amin el fasl";
        |_->print_string"Thank you for visiting EUI\nBYE ";print_endline (user.name);
in 
chatbot()

;;


(*starting the program*)
main();; 
