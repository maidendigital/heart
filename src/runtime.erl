-module(runtime).
-behaviour(gen_server).

%% API
-export([stop/1, start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-record(state, {dummy}).

stop(Name) ->
   gen_server:call(Name, stop).

start_link(Name) ->
   gen_server:start_link({local, Name}, ?MODULE, [], []).

init(_Args) ->
   {ok, [1]}.

handle_call(stop, _From, State) ->
   {stop, normal, stopped, State};
handle_call({set, Some}, _From, State) ->
   {reply, ok, [Some|State]};
handle_call(check, _From, State) ->
    {reply, State, State}.

handle_cast(_Msg, State) ->
   {noreply, State}.

handle_info(_Info, State) ->
   {noreply, State}.

terminate(_Reason, _State) ->
   ok.

code_change(_OldVsn, State, _Extra) ->
   {ok, State}.