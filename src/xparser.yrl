Nonterminals
program
statements statement
primitive
elems elems_even elems_odd elem.

Terminals
'(' ')'
'[' ']'
'{' '}'
int bool
atom string.

Rootsymbol
program.

program ->
  statements               : '$1'.

statements ->
  statement statements     : ['$1' | '$2'].
statements ->
  statement                : ['$1'].

statement  ->
  '(' ')'                  : [].
statement  ->
  '(' elems ')'            : '$2'.
statement  ->
  '[' ']'                  : ['vector'].
statement  ->
  '[' elems ']'            : ['vector'|'$2'].
statement  ->
  '{' '}'                  : ['hash-map'].
%% Maybe need to move even elements restriction into runtime?
statement  ->
  '{' elems_even '}'       : ['hash-map'|'$2'].

primitive -> int           : unwrap('$1').
primitive -> bool          : unwrap('$1').
primitive -> atom          : unwrap('$1').
primitive -> string        : unwrap('$1').

elems ->
  elem                     : ['$1'].
elems ->
  elem elems               : ['$1'|'$2'].
elems_even ->
  elem elem                : ['$1','$2'].
elems_even ->
  elem elem elem elems_odd : ['$1'|['$2'|['$3'|'$4']]].
elems_odd ->
  elem                     : ['$1'].
elems_odd ->
  elem elems_even          : ['$1'|'$2'].

elem  ->
  primitive                : '$1'.
elem  ->
  statement                : '$1'.

Erlang code.

unwrap({_Token, _Line, Value}) -> Value.