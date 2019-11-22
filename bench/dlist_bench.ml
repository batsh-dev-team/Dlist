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
      concat (i - 1) (Dlist.append acc dlst)
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
