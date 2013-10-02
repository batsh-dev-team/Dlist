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

type 'a t

(* Construction *)

val to_list : 'a t -> 'a list
val of_list : 'a list -> 'a t
val of_dlist : 'a t -> 'a t
val empty : unit -> 'a t
val append : 'a t -> 'a t -> 'a t
val concat : 'a t list -> 'a t

(* Basic functions *)

val rev : 'a t -> 'a t
val hd : 'a t -> 'a option
val hd_exn : 'a t -> 'a
val tl : 'a t -> 'a t option
val tl_exn : 'a t -> 'a t
val nth : 'a t -> int -> 'a option
val nth_exn : 'a t -> int -> 'a

(* Reduction *)

val fold : 'a t -> init:'acc -> f:('acc -> 'a -> 'acc) -> 'acc
val fold_left : 'a t -> init:'acc -> f:('acc -> 'a -> 'acc) -> 'acc
val fold_right : 'a t -> init:'acc -> f:('a -> 'acc -> 'acc) -> 'acc
val foldi : 'a t -> init:'acc -> f:(int -> 'acc -> 'a -> 'acc) -> 'acc
val map : 'a t -> f:('a -> 'b) -> 'b t
val mapi : 'a t -> f:(int -> 'a -> 'b) -> 'b t
val iter : 'a t -> f:('a -> unit) -> unit
val iteri : 'a t -> f:(int -> 'a -> unit) -> unit
