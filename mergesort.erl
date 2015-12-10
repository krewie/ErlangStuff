-module(mergesort).
-export([splitMerge/1]).

splitMerge([]) -> [];
splitMerge([Y]) -> [Y];
splitMerge(List) ->
  {L,R} = lists:split(length(List) div 2, List), lists:merge([splitMerge(L),splitMerge(R)]).
