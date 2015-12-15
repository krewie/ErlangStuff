-module(srvtimer).
-behaviour(gen_server).
-export([start_link/0, init/1,cast/1, castMsg/2,
callMsg/3, call/1,handle_call/3,handle_cast/2,handle_info/2,
terminate/2, code_change/3]).

-define(INTERVAL, 1000).
-define(TIMEOUT, 2000).

start_link() -> gen_server:start_link(?MODULE, [], []).

init([]) ->
  %% TODO : set State and Timeout
  erlang:send_after(?INTERVAL, self(), timeout),
  {ok, init, ?TIMEOUT}.

call(Pid) -> gen_server:call(Pid, message).
cast(Pid) -> gen_server:cast(Pid, cast).

handle_call(Message, From, State) ->
  %% TODO : set State and Timeout
  proc_lib:spawn_link(?MODULE, callMsg, [Message, From, State]),
  {reply, ok, State, ?TIMEOUT}.

handle_cast(Message, State) ->
  %% TODO : set State and Timeout
  proc_lib:spawn_link(?MODULE, castMsg, [Message, State]),
  {noreply, State, ?TIMEOUT}.

handle_info(timeout, State) ->
  %% Function call every 60 minutes
  kick:timeout(),
  erlang:send_after(?INTERVAL, self(), timeout),
  %% TODO : set State and Timeout
  {noreply, State, ?TIMEOUT}.

code_change(_OldVsn, _State, _Extra) -> {ok, ok}.

terminate(normal, _State) -> ok.

castMsg(Msg, State) ->
  timer:sleep(20000),
  io:format("Msg: ~p, State: ~p~n", [Msg, State]).

callMsg(From, Msg, State) ->
  timer:sleep(20000),
  io:format("From: ~p, ~p, State: ~p~n", [From, Msg, State]).
