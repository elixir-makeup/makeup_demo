-module(test).
-export([
    listen/1,
    handle_client/1,
    maintain_clients/1,
    start/1,
    stop/0,
    controller/1
]).

-author("jerith").

-define(TCP_OPTIONS, [list, {packet, 0}, {active, false}, {reuseaddr, true}]).

-record(player, {name = none, socket, mode}).

%% To allow incoming connections, we need to listen on a TCP port.
%% This is also the entry point for our server as a whole, so it
%% starts the client_manager process and gives it a name so the rest
%% of the code can get to it easily.

listen(Port) ->
    {ok, LSocket} = gen_tcp:listen(Port, ?TCP_OPTIONS),
    register(client_manager, spawn(?MODULE, maintain_clients, [[]])),
    do_accept(LSocket).

maintain_clients(Players) ->
    io:format("Players:~n", []),
    lists:foreach(fun(P) -> io:format(">>> ~w~n", [P]) end, Players),
    receive
        {connect, Socket} ->
            Player = #player{socket = Socket, mode = connect},
            send_prompt(Player),
            io:format("client connected: ~w~n", [Player]),
            NewPlayers = [Player | Players];
        {disconnect, Socket} ->
            Player = find_player(Socket, Players),
            io:format("client disconnected: ~w~n", [Player]),
            NewPlayers = lists:delete(Player, Players);
        {data, Socket, Data} ->
            Player = find_player(Socket, Players),
            NewPlayers = parse_data(Player, Players, Data),
            NewPlayer = find_player(Socket, NewPlayers),
            send_prompt(NewPlayer)
    end,
    maintain_clients(NewPlayers).

%% find_player is a utility function to get a player record associated
%% with a particular socket out of the player list.

find_player(Socket, Players) ->
    {value, Player} = lists:keysearch(Socket, #player.socket, Players),
    Player.

%% delete_player returns the player list without the given player.  It
%% deletes the player from the list based on the socket rather than
%% the whole record because the list might hold a different version.

delete_player(Player, Players) ->
    lists:keydelete(Player#player.socket, #player.socket, Players).

%% Sends an appropriate prompt to the player.  Currently the only
%% prompt we send is the initial "Name: " when the player connects.

send_prompt(Player) ->
    case Player#player.mode of
        connect ->
            gen_tcp:send(Player#player.socket, "Name: ");
        active ->
            ok
    end.

%% Sends the given data to all players in active mode.

send_to_active(Prefix, Players, Data) ->
    ActivePlayers = lists:filter(
        fun(P) -> P#player.mode == active end,
        Players
    ),
    lists:foreach(
        fun(P) -> gen_tcp:send(P#player.socket, Prefix ++ Data) end,
        ActivePlayers
    ),
    ok.

get_timestamp() ->
    {{Year, Month, Day}, {Hour, Min, Sec}} = erlang:universaltime(),
    lists:flatten(
        io_lib:format(
            "~4.10.0B-~2.10.0B-~2.10.0BT~2.10.0B:~2.10.0B:~2.10.0BZ",
            [Year, Month, Day, Hour, Min, Sec]
        )
    ).

a_binary() ->
    <<100:16/integer, 16#7f>>.

a_list_comprehension() ->
    [X * 2 || X <- [1, 2, 3]].

a_map() ->
    M0 = #{a => 1, b => 2},
    M1 = M0#{b := 200}.

escape_sequences() ->
    [
        "\b\d\e\f\n\r\s\t\v\'\"\\",
        % octal
        "\1\12\123",
        % short hex
        "\x01",
        % long hex
        "\x{fff}",
        % control characters
        "\^a\^A"
    ].

map(Fun, [H | T]) ->
    [Fun(H) | map(Fun, T)];
map(Fun, []) ->
    [].

%% pmap, just because it's cool.

pmap(F, L) ->
    Parent = self(),
    [
        receive
            {Pid, Result} ->
                Result
        end
     || Pid <- [
            spawn(fun() ->
                Parent ! {self(), F(X)}
            end)
         || X <- L
        ]
    ].
