-module(srvtimer).
-behaviour(gen_server).
-export([start_link/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(INTERVAL, 1000).

start_link() -> gen_server:start_link(?MODULE, [], []).

init([]) ->
  %% TODO : set State and Timeout
  %%erlang:send_after(?INTERVAL, self(), timeout),
  {ok, init, ?INTERVAL}.

handle_call(_Message, _From, State) ->
  %% TODO : set State and Timeout
  io:format("Hello CALL"),
  {reply, ok, State, ?INTERVAL}.

handle_cast(_Message, State) ->
  %% TODO : set State and Timeout
  io:format("Hello CAST"),
  {noreply, State, ?INTERVAL}.

handle_info(timeout, State) ->
  %% Function call every 60 minutes
  kick:timeout(),
  %%erlang:send_after(?INTERVAL, self(), timeout),
  %% TODO : set State and Timeout
  {noreply, State, ?INTERVAL}.

code_change(_OldVsn, _State, _Extra) -> {ok, ok}.

terminate(normal, _State) -> ok.
