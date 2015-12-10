-module(test).
-export([mergeSort/1, occurance/2, histo/2, histogram/1, histosum/1, histodist/1, normalize/1]).

mergeSort([]) -> [];
mergeSort([Y]) -> [Y];
mergeSort(List) ->
  {L,R} = lists:split(length(List) div 2, List), lists:merge([mergeSort(L),mergeSort(R)]).

occurance(_N, []) -> 0;
occurance(N, [H|T]) ->
  case N == H of
    true -> 1 + occurance(N, T);
    false -> occurance(N, T)
  end.

% [H|T] has to be a sorted list %
% Builds a proplist with keys from N to 20 where the value associated
% with each key is based on the # of occurances in list L.
histo(_,N) when N > 20 -> [];
histo([H|T], N) when H == N -> [{N, occurance(H, [H|T])}] ++ histo([X || X <- T, X /= H], N+1);
histo(L, N) -> [{N, 0}] ++ histo(L, N+1).

histogram(L) -> histo(mergeSort(L), 1).

% Takes a list of proplists and sums the values for matching keys
histosum([]) -> [];
histosum([H|T]) -> orddict:merge(fun(_K, V1,V2) -> V1+V2 end, H, histosum(T)).

% Takes a proplist as parameter, For each value in proplist, divides the value by 100 and appends to empty list.
histodist(L) -> [V/100 || {_K,V} <- L , V /= 0].

normalize(L) ->
  LSUM = histosum(L),
  {LSUM, histodist(LSUM)}.
