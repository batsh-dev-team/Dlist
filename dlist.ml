(* See http://hackage.haskell.org/package/dlist-0.5/src/Data/DList.hs *)

type 'a t = ('a list -> 'a list)

let to_list dlist =
  dlist []

let from_list lst =
  (fun tail ->
     lst @ tail
  )

let concat dlist1 dlist2 =
  (fun tail ->
     dlist1 (dlist2 tail)
  )

let empty () =
  from_list []
