# OCaml Difference List

A **pure functional** list-like data structure supporting O(1) concatenation. This is particularly useful for efficient list construction from many lists. It is an immutable data type containing no side effect.

The idea is inspired by Haskell [Data.Dlist](http://hackage.haskell.org/package/dlist-0.5) and the APIs are influenced by [Core.List](https://ocaml.janestreet.com/ocaml-core/latest/doc/core_kernel/Core_list.html).

## Documentation

See http://byvoid.github.io/Dlist/Dlist.html

## Example

```ocaml
let dlst1 = Dlist.of_list [1;2;3;4;5] in
let dlst2 = Dlist.of_list [6;7;8;9;10] in
let dlst = Dlist.append dlst1 dlst2 in (* O(1) *)
let lst = Dlist.to_list dlst
```

## Benchmark

Generate 100 lists where every list contains 100 random integers, and concatenate them with `@` for list and `Dlist.append` for Dlist.

	  Name       Time/Run   Speedup  
	 ------- ------------- --------- 
	  list    112_341_988      1.00  
	  dlist    12_571_208      8.94 

## License

[BSD3](http://opensource.org/licenses/BSD-3-Clause)
