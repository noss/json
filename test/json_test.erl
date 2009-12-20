-module(json_test).

-include_lib("eunit/include/eunit.hrl").

encode_decode(Data) ->
    json:decode(json:encode(Data)).

string_test() ->
    Data = <<"this is a simple string">>,
    ?assertEqual(Data, encode_decode(Data)),
    ok.

list_test() ->
    Data = [<<"a">>, <<"b">>],
    ?assertEqual(Data, encode_decode(Data)),
    ok.

map_test() ->
    Data = {struct, [{<<"a">>, 1}, {<<"b">>, 2}]},
    ?assertEqual(Data, encode_decode(Data)),
    ok.

pi_test() ->
    Data = 3.141592,
    ?assertEqual(Data, encode_decode(Data)),
    ok.

