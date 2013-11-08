# OCaml Difference List

Dlist (Difference List) is a **purely functional** list-like data structure supporting O(1) concatenation.
This is particularly useful for efficient list construction from many lists.
Dlist is a lazy immutable data type with no side effect.

This data structure is very handy when your algorithm requires lots of concatenations from many lists.

The idea is inspired by Haskell [Data.Dlist](http://hackage.haskell.org/package/dlist-0.5) and the APIs are influenced by [Core.List](https://ocaml.janestreet.com/ocaml-core/latest/doc/core_kernel/Core_list.html).

## Installation

Using [OPAM](http://opam.ocaml.org/pkg/dlist/0.0.3/):

    opam install dlist

From source:

    opam install ocp-build ounit core_bench
    ocp-build build
    ocp-build install

## Documentation

http://byvoid.github.io/Dlist/Dlist.html

## Example

```ocaml
let dlst1 = Dlist.of_list [1;2;3;4;5] in
let dlst2 = Dlist.of_list [6;7;8;9;10] in
let dlst = Dlist.append dlst1 dlst2 in (* O(1) *)
let lst = Dlist.to_list dlst
```

## Time complexity

O(1) operations:

* Dlist.empty
* Dlist.append
* Dlist.concat
* Dlist.rev
* Dlist.map
* Dlist.mapi
* Dlist.map2

O(N) operations:

* Dlist.to_list
* Dlist.of_list
* Dlist.of_dlist
* Dlist.length
* Dlist.hd
* Dlist.tl
* Dlist.nth
* Dlist.fold
* Dlist.iter

## Benchmark

Generate 100 lists where every list contains 100 random integers, and concatenate them with `@` for list and `Dlist.append` for Dlist.

	  Name       Time/Run   Speedup  
	 ------- ------------- --------- 
	  list    112_341_988      1.00  
	  dlist    12_571_208      8.94 

## License

[BSD3](http://opensource.org/licenses/BSD-3-Clause)
