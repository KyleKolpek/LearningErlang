-module(useless).
-export([add/2, add/3, hello/0, greet_and_add_two/1, testguards/1,
         testguards2/1]).

add(A, B) ->
    A + B.

add(A, B, C) ->
    A + B + C.

% Hello world function!
hello() ->
    io:format("Hello World!~n").

greet_and_add_two(X) ->
    hello(),
    add(X,2).

testguards(X) when X < 16 -> one;
testguards(X) when X < 32 -> two;
testguards(X) when X < 64 -> three;
testguards(_) -> four.

testguards2(X) ->
    if X < 16  -> one;
       X < 32  -> two;
       X < 64  -> three;
       X >= 64 -> four
    end.
