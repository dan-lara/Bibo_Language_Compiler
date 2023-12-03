%{
  #include "bibo.tab.h"

  #include<string>
  #include<iostream>
  using namespace std;
  
  FILE *reconhecimento;
  FILE *cpp;
  bool saida_prog;
%}

%option yylineno

letra   [a-zA-Z]
digito  [0-9]
especiais [\"!#$%^&*()_+=.,/?-]
%%

"dielson" {
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"", yytext);
  fprintf(cpp, "int main() {");
  return MAIN; 
}
"true"  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"TRUE", yytext);
  fprintf(cpp, "true");
  return TRUE; 
}
"false" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"FALSE", yytext);
  fprintf(cpp, "false");
  return FALSE; 
}
"int" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"INT", yytext);
  fprintf(cpp, "int ");
  return INT; 
}
"float" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"FLOAT", yytext);
  fprintf(cpp, "float ");
  return FLOAT; 
}
"char"  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"CHAR", yytext);
  fprintf(cpp, "char ");
  return CHAR; 
}
"edilson"  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"ENDMAIN", yytext);
  fprintf(cpp, "return 0;\n}");
  return ENDMAIN; 
}
"retour"  {
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"RETURN", yytext);
  fprintf(cpp, "return ");
  return RETURN; 
}
\n|(\n(\n)+)  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"\\n\"\n",yylineno-1, "PULALINHA");
  fprintf(cpp, "\n");
  return PULALINHA; 
}
"bibo" {
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"RETURN", yytext);
  fprintf(cpp, "endl");
  return ENDLINE;
}

"=="  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"IGUAL", yytext);
  fprintf(cpp, "==");
  return IGUAL; 
}
">="  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"MAIORIG", yytext);
  fprintf(cpp, ">=");
  return MAIORIG; 
}
"<="  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"MENORIG", yytext);
  fprintf(cpp, "<=");
  return MENORIG; 
}
">" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"MAIOR", yytext);
  fprintf(cpp, ">");
  return MAIOR; 
}
"<" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"MENOR", yytext);
  fprintf(cpp, "<");
  return MENOR; 
}
"/="  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"DIFERENTE", yytext);
  fprintf(cpp, "!=");
  return DIFERENTE; 
} 

"+" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"SOMA", yytext);
  fprintf(cpp, "+");
  return SOMA; 
} 
"-" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"SUB", yytext);
  fprintf(cpp, "-");
  return SUB; 
}
("++"|"--") { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"AUTOATR", yytext);
  fprintf(cpp, "%s", yytext);
  return AUTOATR;
}
"*" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"MULT", yytext);
  fprintf(cpp, "*");
  return MULT; 
}
"/" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"DIV", yytext);
  fprintf(cpp, "/");
  return DIV; 
}
"%" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"MOD", yytext);
  fprintf(cpp, "%%");
  return MOD; 
}

"&&&" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"AND", yytext);
  fprintf(cpp, "&&");
  return AND; 
}
"|||" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"OR", yytext);
  fprintf(cpp, "||");
  return OR; 
}
"~" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"NOT", yytext);
  fprintf(cpp, "!");
  return NOT; 
}

"=" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"ATR", yytext);
  fprintf(cpp, "=");
  return ATR; 
}
"><"  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"ENTRADA", yytext);
  fprintf(cpp, "cin >> ");
  return ENTRADA; 
}
">>"    {
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"CONCATIN", yytext);
  fprintf(cpp, " >> ");
  return CONCATIN; 
}
"<>"  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"SAIDA", yytext);
  fprintf(cpp, "cout << ");
  return SAIDA; 
}
"<<"    {
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"CONCATOUT", yytext);
  fprintf(cpp, " << ");
  return CONCATOUT; 
}

"?" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"IF", yytext);
  fprintf(cpp, "if ");
  return IF; 
}
"!" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"ELSE", yytext);
  fprintf(cpp, "}else ");
  return ELSE; 
}

"_8"  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"WHILE", yytext);
  fprintf(cpp, "while ");
  return WHILE; 
}
"_4"  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"FOR", yytext);
  fprintf(cpp, "for");
  return FOR; 
}

"(" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"ABRPARENTESES", yytext);
  fprintf(cpp, "(");
  return ABRPARENTESES; 
}
")" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"FECPARENTESES", yytext);
  fprintf(cpp, ")");
  return FECPARENTESES; 
}
"." { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"PONTO", yytext);
  fprintf(cpp, ";");
  return PONTO; 
}
"," { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"SEPARADOR", yytext);
  fprintf(cpp, ", ");
  return SEPARADOR; 
}
":" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"INICIO", yytext);
  fprintf(cpp, "{");
  return INICIO; 
}
";" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"FIM", yytext);
  fprintf(cpp, "}");
  return FIM; 
} 

[-]?{digito}+(","{digito}+) { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"NUMFLOAT", yytext);
  char *ptr = strchr(yytext, ',');
  *ptr = '.';
  fprintf(cpp, "%s", yytext);
  return NUMFLOAT;
}

[-]?{digito}+ { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"NUMINT", yytext);
  fprintf(cpp, "%s", yytext);
  return NUMINT;
}

"'"({letra}|{digito}|{especiais})"'" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"CARACTER", yytext);
  fprintf(cpp, "%s", yytext);
  return CARACTER;
}
"\""({letra}|{digito}|{especiais}|" ")+"\"" { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"STRING", yytext);
  fprintf(cpp, "%s", yytext);
  return STRING;
}
{letra}({digito}|{letra}|"_")*  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"ID", yytext);
  fprintf(cpp, "%s", yytext);
  return ID;
}
"_"{letra}({digito}|{letra}|"_")*  { 
  fprintf(reconhecimento, "{%2d} %-13s =\t\"%s\"\n", yylineno,"NOMEFUNC", yytext);
  fprintf(cpp, "%s", yytext);
  return NOMEFUNC;
}



[ \t]+ { }
. { }

%%

int yywrap();

int main(int argc, char *argv[]) {
  FILE *programa = fopen(argv[1],"r");

  if (!programa) {
    cout << "Não foi possível ler o arquivo." << endl;
    return -1;
  }

  yyin = programa;
  reconhecimento = fopen(argv[2],"w");
  cpp = fopen(argv[3],"w");
  fprintf(cpp, "#include <bits/stdc++.h>\nusing namespace std;\n");
  saida_prog = false;
  yyparse();
  yylex();

  return 0;
}

int yywrap(){
  return 1;
}