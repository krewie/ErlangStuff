-module(kick).
-export([timeout/0]).

timeout() ->
io:format("Timeout occured at : ~p~n", [erlang:time()]).
