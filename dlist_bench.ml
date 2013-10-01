open Core.Std
open Core_bench.Std

let random_int_list length =
  let rec make_list acc elems_left =
    if elems_left = 0 then
      acc
    else
      let element = Random.bits () in
      make_list (element :: acc) (elems_left - 1)
  in
  make_list [] length

let list_bench ~num_lists ~num_elems_in_list =
  let rec concat i acc =
    if i <= 0 then
      acc
    else
      let lst = random_int_list num_elems_in_list in
      concat (i - 1) (acc @ lst)
  in
  let lst = concat num_lists [] in
  List.iter lst ~f: (fun _ -> ())

let dlist_bench ~num_lists ~num_elems_in_list =
  let rec concat i (acc : int Dlist.t) : int Dlist.t =
    if i <= 0 then
      acc
    else
      let dlst = Dlist.of_list (random_int_list num_elems_in_list) in
      concat (i - 1) (Dlist.concat acc dlst)
  in
  let lst = Dlist.to_list (concat num_lists (Dlist.empty ())) in
  List.iter lst ~f: (fun _ -> ())

let tests ~num_lists ~num_elems_in_list =
  let test name f = Bench.Test.create f ~name in
  [
    test "list"   (fun () -> list_bench ~num_lists ~num_elems_in_list);
    test "dlist"   (fun () -> dlist_bench ~num_lists ~num_elems_in_list)
  ]

let () =
  tests ~num_lists: 100 ~num_elems_in_list: 100
  |> Bench.make_command
  |> Command.run
