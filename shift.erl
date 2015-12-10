-module(shift).
-export([mod/2,letter_pos/1,hash_encrypt/2,hash_decrypt/2, encrypt/2, decrypt/2]).


%initDict(Dict) -> popDict(65, 0, Dict).
%Creates a dictionary recursivly from a - z with values 0 - 25
%popDict(91, _Count, Dict) -> Dict;
%popDict(Lower, Count, Dict) -> popDict(Lower+1, Count+1, dict:store([Lower], Count, Dict)).

%alphabet(91) -> [];
%alphabet(L) -> [L] ++ createList(L+1).

mod(X,Y) when X > 0 -> X rem Y;
mod(X,Y) when X < 0 -> Y + X rem Y;
mod(0,_Y) -> 0.

letter_pos(N) when N >= 65, N =< 90 ->
true;
letter_pos(_) ->
false.

hash_encrypt(X, K) -> mod(X+K, 26).
hash_decrypt(X, K) -> mod(X-K, 26).

encrypt([] ,_K) -> [];
encrypt([H|T] ,K) ->
  case letter_pos(string:to_upper(H)) of
    true -> [hash_encrypt(string:to_upper(H) rem 65, K)+65] ++ encrypt(T, K);
    false -> error
  end.

  decrypt([] ,_K) -> [];
  decrypt([H|T] ,K) ->
    case letter_pos(string:to_upper(H)) of
      true -> [hash_decrypt(string:to_upper(H) rem 65, K)+65] ++ decrypt(T, K);
      false -> error
    end.
