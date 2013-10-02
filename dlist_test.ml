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

let test_rev _ =
  let lst = [1;2;3] in
  let dlst = Dlist.of_list lst in
  let reversed_dlst = Dlist.rev dlst in
  let reversed_lst = List.rev lst in
  assert_equal reversed_lst (Dlist.to_list reversed_dlst)

let test_cases = "Dlist Unit Tests" >::: [
    "Empty" >:: test_empty;
    "Append" >:: test_append;
    "Concat" >:: test_concat;
    "Map" >:: test_map;
    "Rev" >:: test_rev;
  ]

let _ =
  run_test_tt_main test_cases
