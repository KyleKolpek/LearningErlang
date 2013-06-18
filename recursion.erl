-module(recursion).
-export([fac/1, facTail/1, len/1, lenTail/1, dupeTail/2, reverse/1,
         reverseTail/1, quickSort/1, lcQuickSort/1]).

fac(0) -> 1;
fac(N) when N > 0 -> N * fac(N - 1). 

facTail(N) -> facTail(N, 1).

facTail(0, Acc) -> Acc;
facTail(N, Acc) when N > 0 -> facTail(N - 1, N * Acc).

len([]) -> 0;
len([_|T]) -> 1 + len(T).

lenTail(T) -> lenTail(T, 0).

lenTail([], Acc) -> Acc;
lenTail([_|T], Acc) -> lenTail(T, Acc + 1).

dupeTail(N, Val) -> dupeTail(N, Val, []).

dupeTail(0, _, Ret) -> Ret;
dupeTail(N, Val, Ret) when N > 0 -> dupeTail(N-1, Val, [Val|Ret]).

reverse([]) -> [];
reverse([H|T]) -> reverse(T) ++ [H].

reverseTail(L) -> reverseTail(L, []).

reverseTail([], Ret) -> Ret;
reverseTail([H|T], Ret) -> reverseTail(T, [H|Ret]).

quickSort([]) -> [];
quickSort([Pivot|Rest]) ->
    {Smaller, Larger} = partition(Pivot, Rest, [], []),
    quickSort(Smaller) ++ [Pivot] ++ quickSort(Larger).

partition(_, [], Smaller, Larger) -> {Smaller, Larger};
partition(Pivot, [H|T], Smaller, Larger) ->
    if H =< Pivot -> partition(Pivot, T, [H|Smaller], Larger);
       H >  Pivot -> partition(Pivot, T, Smaller, [H|Larger])
    end. 

lcQuickSort([]) -> [];
lcQuickSort([Pivot|Rest]) ->
    lcQuickSort([Smaller || Smaller <- Rest, Smaller =< Pivot])
    ++ [Pivot] ++
    lcQuickSort([Larger || Larger <- Rest, Larger > Pivot]).
