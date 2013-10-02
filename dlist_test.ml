open OUnit

let test_empty _ =
  let dlst = Dlist.empty () in
  let lst = Dlist.to_list dlst in
  assert_equal [] lst

let test_append _ =
  let lst1 = [1;2;3] in
  let dlst1 = Dlist.of_list lst1 in
  let lst2 = [6;2;7;3] in
  let dlst2 = Dlist.of_list lst2 in
  let dlst = Dlist.append dlst1 dlst2 in
  let lst = Dlist.to_list dlst in
  assert_equal (lst1 @ lst2) lst

let test_concat _ =
  let lst1 = [1;2;3] in
  let dlst1 = Dlist.of_list lst1 in
  let lst2 = [6;2;7;3] in
  let dlst2 = Dlist.of_list lst2 in
  let dlst = Dlist.concat [dlst1; dlst2] in
  let lst = Dlist.to_list dlst in
  assert_equal (lst1 @ lst2) lst

let test_map _ =
  let lst = [1;2;3] in
  let dlst = Dlist.of_list lst in
  let f a = a * 3 in
  let mapped_dlst = Dlist.map ~f dlst in
  let mapped_lst = List.map f lst in
  assert_equal mapped_lst (Dlist.to_list mapped_dlst)

let test_cases = "Dlist Unit Tests" >::: [
    "Empty" >:: test_empty;
    "Append" >:: test_append;
    "Concat" >:: test_concat;
    "Map" >:: test_map;
  ]

let _ =
  run_test_tt_main test_cases
