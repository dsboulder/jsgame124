%%
\s+                         {return 'SPACE'}
[+-]?[0-9]+("."[0-9]+)?\b   {return 'NUMBER';}
"Action"|"Action"           {return 'ACTION';}
"Buy"|"Buys"                {return 'BUY';}
"Card"|"Cards"              {return 'CARD';}
\n                          {return 'NEWLINE';}
<<EOF>>                     {return 'EOF';}