type 'a t

val to_list : 'a t -> 'a list
val of_list : 'a list -> 'a t
val of_dlist : 'a t -> 'a t
val concat : 'a t -> 'a t -> 'a t
val empty : unit -> 'a t
val fold : 'a t -> init:'acc -> f:('acc -> 'a -> 'acc) -> 'acc
val fold_left : 'a t -> init:'acc -> f:('acc -> 'a -> 'acc) -> 'acc
val fold_right : 'a t -> init:'acc -> f:('a -> 'acc -> 'acc) -> 'acc
val foldi : 'a t -> init:'acc -> f:(int -> 'acc -> 'a -> 'acc) -> 'acc
val map : 'a t -> f:('a -> 'b) -> 'b t
val mapi : 'a t -> f:(int -> 'a -> 'b) -> 'b t
val iter : 'a t -> f:('a -> unit) -> unit
val iteri : 'a t -> f:(int -> 'a -> unit) -> unit
