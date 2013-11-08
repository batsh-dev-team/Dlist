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

(** Difference list: a list-like data structure with O(1) concatenation. *)
(** Every method listed below is {b tail recursive}, so you can use them safely.
The APIs are inspaired by {{: https://ocaml.janestreet.com/ocaml-core/latest/doc/core_kernel/Core_list.html}
Core.List}.
*)

(** The abstract type of Dlist. *)
type 'a t

(* Construction *)

(** Convert a Dlist to an OCaml list. O(N), where N is the number of elements. *)
val to_list : 'a t -> 'a list

(** Convert an OCaml list to a Dlist. O(N). *)
val of_list : 'a list -> 'a t

(** Convert a Dlist to a Dlist by reconstruction. O(N) (strict evaluation). *)
val of_dlist : 'a t -> 'a t

(** Return an empty Dlist. O(1). *)
val empty : unit -> 'a t

(** Concatenate two Dlists. O(1). *)
val append : 'a t -> 'a t -> 'a t

(** Concatenate a list of Dlists. O(M), where M is the number of Dlists. *)
val concat : 'a t list -> 'a t

(* Basic functions *)

(** Return the length of the given Dlist.
	O(N). *)
val length : 'a t -> int

(** Reverse a Dlist.
	O(1) (lazy evaluation). *)
val rev : 'a t -> 'a t

(** Return the first element of the given Dlist.
	O(N). *)
val hd : 'a t -> 'a option

(** Return the first element of the given Dlist.
	Raise Failure "hd" if the Dlist is empty.
	O(N). *)
val hd_exn : 'a t -> 'a

(** Return the given Dlist without its first element.
	O(N). *)
val tl : 'a t -> 'a t option

(** Return the given Dlist without its first element.
	Raise Failure "tl" if the Dlist is empty.
	O(N). *)
val tl_exn : 'a t -> 'a t

(** Return the n-th element of the given Dlist.
	The first element (head of the Dlist) is at position 0.
	O(N). *)
val nth : 'a t -> int -> 'a option

(** Return the n-th element of the given Dlist.
	The first element (head of the Dlist) is at position 0.
	Raise Failure "nth" if the Dlist is too short.
	Raise Invalid_argument "List.nth" if n is negative.
	O(N). *)
val nth_exn : 'a t -> int -> 'a

(* Reduction *)

(** Fold the Dlist. O(N). *)
val fold : 'a t -> init:'acc -> f:('acc -> 'a -> 'acc) -> 'acc

(** Fold the Dlist from left. O(N). *)
val fold_left : 'a t -> init:'acc -> f:('acc -> 'a -> 'acc) -> 'acc

(** Fold the Dlist from right. O(N). *)
val fold_right : 'a t -> init:'acc -> f:('a -> 'acc -> 'acc) -> 'acc

(** Fold the Dlist with index. O(N). *)
val foldi : 'a t -> init:'acc -> f:(int -> 'acc -> 'a -> 'acc) -> 'acc

(** Map the Dlist. O(1) (lazy evaluation). *)
val map : 'a t -> f:('a -> 'b) -> 'b t

(** Map the Dlist with index. O(1) (lazy evaluation). *)
val mapi : 'a t -> f:(int -> 'a -> 'b) -> 'b t

(** Iterate the Dlist. O(N). *)
val iter : 'a t -> f:('a -> unit) -> unit

(** Iterate the Dlist with index. O(N). *)
val iteri : 'a t -> f:(int -> 'a -> unit) -> unit
