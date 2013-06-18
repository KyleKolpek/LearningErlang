-module(rpnCalc).
-export([rpnCalc/0, convertToken/1]).

% rpnCalc/0
% Starts the calculator prompt by calling rpnCalc/1. It passes 'start', although
% any value other than the 'ok' atom should be fine.

rpnCalc() ->
    rpnCalc(start).

% rpnCalc/1
% Continues to take input until param1 is 'ok'.
% There's probably a better way to terminate than this.
rpnCalc(ok) -> ok;
rpnCalc(_) ->
    [X] = lists:foldl(fun rpnCalc/2, [], getTokens()),
    io:fwrite("~w~n",[X]),
    rpnCalc(X).

% getTokens/0
% Takes input from stdin and returns a list of tokens
getTokens() ->
    X = lists:takewhile(fun(X) -> [X] =/= "\n" end, io:get_line("#> ")),
    string:tokens(X, " ").

% convertToken/1
% Attempts to convert a token, T, to a float or an integer.
convertToken(T) ->
    try
        list_to_float(T)
    catch
        error:badarg -> list_to_integer(T)
    end.

% rpnCalc/2
% Takes a token representing either an operator or a token representing a 
% numeric value along with a stack of numeric values previously read. Either 
% applys the operator to values on the stack, or converts the token to a
% numeric value and adds it to the stack.

rpnCalc("end", _) -> [ok];
rpnCalc("+", [A, B | T])  -> [B + A | T];
rpnCalc("-", [A, B | T])  -> [B - A | T];
rpnCalc("/", [A, B | T])  -> [B / A | T];
rpnCalc("%", [A, B | T])  -> [B rem  A | T];
rpnCalc("^", [A, B | T])  -> [math:pow(B, A) | T];
rpnCalc("ln", [A | T])    -> [math:ln(A) | T];
rpnCalc(X, Stack) -> [convertToken(X) | Stack].
