let rec choose()=
  print_string"Choice: ";
  let choice = read_line() in 
  match choice with
  |"1"-> "how apply"
  |"2" -> "what tracks"
  |"3" -> "dual degree"
  |"4" -> "entry requirements"
  |"5" -> "why choose"
  |"6" -> "how fees"
  |"7" -> "where university"
  |"8" -> "buses"
  |"9" -> "where dorms"
  |"10" -> "courses"
  |"11" -> " "
  |_ -> print_string"INVALID CHOICE, please try again\n";choose()
  ;;
(*Displaying the menu for the user to choos an option*)
let displaymenu()=
  print_string "The following options are samples of questions that I can answer\n" ;
  print_string "Feel free to choose an option or option 11 to type in your own question\n";
  (*delay_seconds 2;;*)
  print_endline "1. How to apply to EUI?\n2.What are the tracks available in CS?\n3.What is the dual degree agreement?\n4. What are the requirements for applying?\n5. Why choose EUI?\n6. How much are the tuition fees?\n7. Where is EUI located?\n8. Is there transportation available?\n9. Where are the dorms?\n10. What is the study plan?\n11. Ask your own question";
  (*User inputs a choice and it gets validated*)
  (*Keywords get send back to generate output without havong to lex and parse the input*)
  choose()
  ;;

