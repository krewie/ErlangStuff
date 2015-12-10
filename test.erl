-module(test).
-export([mergeSort/1, occurance/2, histo/2, histogram/1]).

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
histo(_,N) when N > 20 -> [];
histo([H|T], N) when H == N -> [{N, occurance(H, [H|T])}] ++ histo([X || X <- T, X /= H], N+1);
histo(L, N) -> [{N, 0}] ++ histo(L, N+1).

histogram(L) -> histo(mergeSort(L), 1).


%orddict:merge(fun(_Key, V1,V2)-> V1+V2 end, X, Y).
%[{1,2},
%{2,4},
%{3,0},
%{4,2},
%{5,10},
%{6,0},
%{7,0},
%{8,0},
%{9,0},
%{10,0},
%{11,0},
%{12,0},
%{13,0},
%{14,0},
%{15,0},
%{16,0},
%{17,0},
%{18,0},
%{19,0},
%{20,0}]
