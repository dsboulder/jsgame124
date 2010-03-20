%%
Statements
  : Statement NEWLINE Statements
    { $$ = [$2].append($1); }
  | Statement EOF
    { $$ = [$1]; }
  ;
Statement
  : NUMBER SPACE ACTION
    { $$ = new GameNS.Cards.Commands.Actions(Number($1)); }
  ;
