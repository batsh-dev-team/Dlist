open OUnit

let test_empty _ =
  let dlst = Dlist.empty () in
  let lst = Dlist.to_list dlst in
  assert_equal [] lst

let test_cases = "Dlist Unit Tests" >:::
                   ["Empty" >:: test_empty]

let _ =
  run_test_tt_main test_cases
