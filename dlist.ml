(* 
Copyright (c) 2013, BYVoid <byvoid@byvoid.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the BYVoid nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL BYVoid <byvoid@byvoid.com> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

type 'a t = ('a list -> 'a list)

(* Construction *)

let to_list dlist =
  dlist []

let of_list lst =
  fun tail ->
    lst @ tail

let append dlst1 dlst2 =
  fun tail ->
    dlst1 (dlst2 tail)

let empty () =
  of_list []

(* Basic functions *)

let rev dlst =
  fun tail ->
    List.rev (dlst tail)

let hd dlst =
  match to_list dlst with
  | elem :: _ ->
    Some elem
  | [] ->
    None

let hd_exn dlst =
  List.hd (to_list dlst)

let tl dlst =
  match to_list dlst with
  | _ :: tail ->
    Some (of_list tail)
  | [] ->
    None

let tl_exn dlst =
  of_list (List.tl (to_list dlst))

let nth dlst n =
  let rec nth_impl lst i =
    match lst with
    | head :: tail ->
      if i = 0 then
        Some head
      else
        nth_impl tail (i - 1)
    | [] ->
      None
  in
  nth_impl (to_list dlst) n

let nth_exn dlst n =
  List.nth (to_list dlst) n

(* Reduction *)

let fold dlst ~init ~f =
  let rec fold_impl lst acc =
    match lst with
    | [] -> acc
    | elem :: tail -> fold_impl tail (f acc elem)
  in
  fold_impl (to_list dlst) init

let fold_left = fold

let fold_right dlst ~init ~f =
  let rec fold_impl lst acc =
    match lst with
    | [] -> acc
    | elem :: tail -> fold_impl tail (f elem acc)
  in
  fold_impl (List.rev (to_list dlst)) init

let foldi dlst ~init ~f =
  let rec fold_impl i lst acc =
    match lst with
    | [] -> acc
    | elem :: tail -> fold_impl (i + 1) tail (f i acc elem)
  in
  fold_impl 0 (to_list dlst) init

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

let concat dlsts =
  List.fold_left (fun acc dlst -> append acc dlst) (empty ()) dlsts
