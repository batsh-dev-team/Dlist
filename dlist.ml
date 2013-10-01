(* See http://hackage.haskell.org/package/dlist-0.5/src/Data/DList.hs *)

type 'a t = ('a list -> 'a list)

let to_list dlist =
  dlist []

let of_list lst =
  fun tail ->
    lst @ tail

let concat dlst1 dlst2 =
  fun tail ->
    dlst1 (dlst2 tail)

let empty () =
  of_list []

let fold dlst ~init ~f =
  let rec fold_impl lst acc =
    match lst with
    | [] -> acc
    | elem :: tail -> fold_impl tail (f acc elem)
  in
  fold_impl (to_list dlst) init

let fold_left = fold

let fold_right lst ~init ~f =
  let rec fold_impl lst acc =
    match lst with
    | [] -> acc
    | elem :: tail -> fold_impl tail (f elem acc)
  in
  fold_impl (List.rev (to_list lst)) init

let foldi lst ~init ~f =
  let rec fold_impl i lst acc =
    match lst with
    | [] -> acc
    | elem :: tail -> fold_impl (i + 1) tail (f i acc elem)
  in
  fold_impl 0 (to_list lst) init

let map dlst ~f =
  let mapped_lst = fold dlst ~init: []
      ~f: (fun acc elem -> (f elem) :: acc)
  in
  of_list (List.rev mapped_lst)

let mapi dlst ~f =
  let mapped_lst = foldi dlst ~init: []
      ~f: (fun i acc elem -> (f i elem) :: acc)
  in
  of_list (List.rev mapped_lst)

let iter dlst ~f =
  fold dlst ~init: () ~f: (fun _ elem -> f elem)

let iteri dlst ~f =
  foldi dlst ~init: () ~f: (fun i _ elem -> f i elem)

let of_dlist dlst =
  map dlst ~f: (fun elem -> elem)
