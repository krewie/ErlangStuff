-module(kick).
-export([timeout/0, call/2]).

call(Pid, Msg) -> gen_server:call(Msg, Pid, ok).
timeout() ->
io:format("Tick occured at : ~p~n", [erlang:time()]).

%kick:call(Pid, "hello").
%c(kick).
